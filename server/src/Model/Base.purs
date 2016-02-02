module Model.Base (module Model.Base, module Database.SQLite) where

import Prelude
import Data.Tuple
import Data.Either
import Control.Monad.Eff
import Control.Monad.Trans

import Database.SQLite
import Config
import Lib.Utils

type Date = String
type Record t = Row (id :: Int, create_at :: Date, update_at :: Date | t)

type Table = String
type Column = String
type QValue = String

data Condition = Eq Column QValue
               | Gt Column QValue
               | Gte Column QValue
               | Lt Column QValue
               | Lte Column QValue

class IsValue a where
  toValue :: a -> QValue

instance isValueInt :: IsValue Int where
  toValue = show

instance isValueString :: IsValue String where
  toValue = show

(.=) :: forall a. (IsValue a) => Column -> a -> Condition
(.=) c v = Eq c (toValue v)

(.>) :: forall a. (IsValue a) => Column -> a -> Condition
(.>) c v = Gt c (toValue v)

(.<) :: forall a. (IsValue a) => Column -> a -> Condition
(.<) c v = Lt c (toValue v)

(.>=) :: forall a. (IsValue a) => Column -> a -> Condition
(.>=) c v = Gte c (toValue v)

(.<=) :: forall a. (IsValue a) => Column -> a -> Condition
(.<=) c v = Lte c (toValue v)

class Relation f where
  (.&&) :: forall a. f a -> a -> f a
  (.||) :: forall a. f a -> a -> f a
  by :: forall a. a -> f a

type Conditions = ConditionsR Condition
data ConditionsR c = CAnd (ConditionsR c) c
         | COr (ConditionsR c) c
         | Where c

type Set = SetR Condition
data SetR c = SAnd (SetR c) c
            | Set c

type Value = ValueR Condition
data ValueR c = VAnd (ValueR c) c
              | Value c

instance relationConditionsR :: Relation ConditionsR where
  (.&&) r c = CAnd r c
  (.||) r c = COr r c
  by = Where

instance relationSetR :: Relation SetR where
  (.&&) r c = SAnd r c
  (.||) r c = r .&& c
  by = Set

instance relationValueR :: Relation ValueR where
  (.&&) r c = VAnd r c
  (.||) r c = r .&& c
  by = Value

data Order = Asc | Desc
data OrderBy = OrderBy Column Order

data Limit = Limit Int Int
           | NoLimit

data Query = Find Table Conditions OrderBy Limit
           | First Table Conditions OrderBy
           | Insert Table Value
           | Update Table Set Conditions
           | Delete Table Conditions
           | Count Table Conditions
           | CreateTable Table (Array Condition)

class ToSql f where
  tosql :: f -> Sql

instance toSqlLimit :: ToSql Limit where
  tosql (Limit offset count) = join_ ["LIMIT", join' [show offset, show count]]
  tosql NoLimit = ""

instance toSqlOrderBy :: ToSql OrderBy where
  tosql (OrderBy col order) = join_ ["ORDER BY", col, order']
    where order' = case order of
            Asc -> "ASC"
            Desc -> "DESC"

instance toSqlCondition :: ToSql Condition where
  tosql c = case c of
    Eq col v -> join_ [col, "=", v]
    Gt col v -> join_ [col, ">", v]
    Gte col v -> join_ [col, ">=", v]
    Lt col v -> join_ [col, "<", v]
    Lte col v -> join_ [col, "<=", v]

instance toSqlConditions :: ToSql (ConditionsR Condition) where
  tosql cs = case cs of
    CAnd cs c -> join_ [tosql cs, "AND", tosql c]
    COr cs c -> join_ [tosql cs, "OR", tosql c]
    Where c -> join_ ["WHERE", tosql c]

instance toSqlSet :: ToSql (SetR Condition) where
  tosql s = case s of
    SAnd s c -> join ", " [tosql s, tosql c]
    Set c -> join_ ["SET", tosql c]

unpack :: Value -> Tuple (Array Column) (Array QValue)
unpack v = case v of
  VAnd v c -> let cols = fst rs ++ [fst r]
                  vals = snd rs ++ [snd r]
                  r = unpackc c
                  rs = unpack v
              in Tuple cols vals
  Value c -> let r = unpackc c
                 col = fst r
                 val = snd r
             in Tuple [col] [val]
  where unpackc c = case c of
          Eq col val -> Tuple col val

instance toSqlValue :: ToSql (ValueR Condition) where
  tosql v = join_ ["(", join' cols, ")", "VALUES", "(", join' vals, ")"]
    where rs = unpack v
          cols = fst rs
          vals = snd rs

instance toSqlQuery :: ToSql Query where
  tosql query = case query of
    Find t cs o l -> join_ ["SELECT * FROM", t, tosql cs, tosql o, tosql l]
    First t cs o -> join_ ["SELECT FIRST(*) FROM", t, tosql cs, tosql o]
    Insert t v -> join_ ["INSERT INTO", t, tosql (v .&& ("update_at" .= "NOW()") .&& ("create_at" .= "NOW()"))]
    Update t s cs -> join_ ["UPDATE", t, tosql (s .&& ("update_at" .= "NOW()")), tosql cs]
    Delete t cs -> join_ ["DELETE FROM", t, tosql cs]
    Count t cs -> join_ ["SELECT COUNT(*) AS count FROM", t, tosql cs]

    CreateTable t ts -> join_ ["CREATE TABLE IF NOT EXISTS", t, "( id INTEGER PRIMARY KEY AUTOINCREMENT,", tosqlts ts, ", create_at DATETIME, update_at DATETIME)"]
      where tosqlts ts = join' $ map tosqlc ts
            tosqlc (Eq k v) = join_ [k, v]

-- getDBFullPath :: forall eff. Async eff String
-- getDBFullPath = do
--   root_path <- liftAsyncEff __dirname
--   return $ join "/" [root_path, database_path]

getDBFullPath :: forall eff. Async eff String
getDBFullPath = mkAsyncEff "/tmp/test.db"

connect :: forall eff. DBAsync eff DB
connect = do
  full_path <- getDBFullPath
  db <- connectDB full_path default_mode
  return db

find :: forall eff t. Table -> Conditions -> OrderBy -> Limit -> DBAsync eff (Array (Record t))
find t cs o l = do
  db <- connect
  records <- allDB db (tosql $ Find t cs o l)
  return records

first :: forall eff t. Table -> Conditions -> OrderBy -> DBAsync eff (Record t)
first t cs o = do
  db <- connect
  record <- getDB db (tosql $ First t cs o)
  return record

findall :: forall eff t. Table -> Conditions -> OrderBy -> DBAsync eff (Array (Record t))
findall t cs o = do
  db <- connect
  records <- allDB db (tosql $ Find t cs o NoLimit)
  return records

insert :: forall eff t. Table -> Value -> DBAsync eff Unit
insert t v = do
  db <- connect
  runDB db (tosql $ Insert t v)

update :: forall eff t. Table -> Set -> Conditions -> DBAsync eff Unit
update t s cs = do
  db <- connect
  runDB db (tosql $ Update t s cs)

delete :: forall eff t. Table -> Conditions -> DBAsync eff Unit
delete t cs = do
  db <- connect
  runDB db (tosql $ Delete t cs)

count :: forall eff. Table -> Conditions -> DBAsync eff Int
count t cs = do
  db <- connect
  result <- getDB db (tosql $ Count t cs)
  return result.count

createTable :: forall eff. Table -> Array Condition -> DBAsync eff Unit
createTable t ts = do
  db <- connect
  runDB db (tosql $ CreateTable t ts)
