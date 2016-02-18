module Model.Base ( module Model.Base
                  , module Database.SQLite.Type) where

import Prelude

import Data.Tuple
import Data.Maybe
import Data.Array ((:))
import Data.Foldable (foldr)

import Control.Monad.Eff.Class

import Lib.Utils

import Database.SQLite.Type
import Database.SQLite
import Data.DateTime

import qualified Config as Config

type Table = String
type Column = String
type Value = String

data OP = Eq | Neq | Gt | Gte | Lt | Lte | Like
data Condition = Condition OP Column Value
               | And Condition Condition
               | Or Condition Condition

newtype ConditionSet = ConditionSet Condition

class IsValue a where
  toValue :: a -> Value

newtype Raw = Raw String

data Assign = Assign Column Value

newtype UpdateValue = UpdateValue (Array Assign)
newtype InsertValue = InsertValue (Array Assign)
newtype Schema = Schema (Array Assign)

data Order = Desc Column
           | Asc Column

data Limit = Limit Int
           | NoLimit

data Offset = Offset Int
            | NoOffset

data Query = Find Table ConditionSet Order Limit Offset
           | First Table ConditionSet Order
           | Insert Table InsertValue
           | InsertOrUpdate Table InsertValue
           | Update Table UpdateValue ConditionSet
           | Delete Table ConditionSet
           | Count Table ConditionSet
           | CreateTable Table Schema

           | Join Table Query

infix 5 .~=
infix 5 .==
infix 5 .!=
infix 5 .>
infix 5 .<
infix 5 .<=

(.==) :: forall a. (IsValue a) => Column -> a -> Condition
(.==) c v = Condition Eq c (toValue v)

(.!=) :: forall a. (IsValue a) => Column -> a -> Condition
(.!=) c v = Condition Neq c (toValue v)

(.>) :: forall a. (IsValue a) => Column -> a -> Condition
(.>) c v = Condition Gt c (toValue v)

(.>=) :: forall a. (IsValue a) => Column -> a -> Condition
(.>=) c v = Condition Gte c (toValue v)

(.<) :: forall a. (IsValue a) => Column -> a -> Condition
(.<) c v = Condition Lt c (toValue v)

(.<=) :: forall a. (IsValue a) => Column -> a -> Condition
(.<=) c v = Condition Lte c (toValue v)

(.~=) :: forall a. (IsValue a) => Column -> a -> Condition
(.~=) c v = Condition Like c (toValue v)

infix 4 .||
infix 4 .&&

(.||) :: Condition -> Condition -> Condition
(.||) a b = Or a b

(.&&) :: Condition -> Condition -> Condition
(.&&) a b = And a b

infix 5 .=
(.=) :: forall a. (IsValue a) => Column -> a -> Assign
(.=) c v = Assign c (toValue v)

infix 5 .=>
(.=>) :: Column -> String -> Assign
(.=>) c v = Assign c (toValue $ Raw v)

class ToSql a where
  tosql :: a -> Sql

-- instance of IsValue
instance isValueRaw:: IsValue Raw where
  toValue (Raw str) = str

instance isValueString :: IsValue String where
  toValue str = escapeString str
  -- toValue str = show str

instance isMaybe :: (IsValue a) => IsValue (Maybe a)  where
  toValue Nothing = "NULL"
  toValue (Just a) = toValue a

instance isValueInt :: IsValue Int where
  toValue int = show int

instance isValueDateTime :: IsValue DateTime where
  toValue Now = "DATETIME('NOW')"
  toValue (DateTime d) = "DATETIME('"
                       ++ join "-" (map show [d.year, d.month, d.day])
                       ++ " "
                       ++ join ":" (map show [d.hour, d.minute, d.second])
                       ++ "')"


-- instance of ToSql

instance toSqlCondition :: ToSql Condition where
  tosql (Condition op col v) = case op of
    Eq -> join_ [col, "=", v]
    Neq -> join_ [col, "!=", v]
    Gt -> join_ [col, ">", v]
    Gte -> join_ [col, ">=", v]
    Lt -> join_ [col, "<", v]
    Lte -> join_ [col, "<=", v]
    Like -> join_ [col, "LIKE", "%" ++ v ++ "%"]
  tosql (And c1 c2) = join_ [tosql c1, "AND", tosql c2]
  tosql (Or c1 c2) = join_ [tosql c1, "OR", tosql c2]

instance toSqlConditionSet :: ToSql ConditionSet where
  tosql (ConditionSet cs) = join_ ["WHERE", tosql cs]

instance toSqlOrder :: ToSql Order where
  tosql (Desc col) = join_ ["ORDER BY", col, "DESC"]
  tosql (Asc col) = join_ ["ORDER BY", col, "ASC"]

instance toSqlLimit :: ToSql Limit where
  tosql (Limit a) = join_ ["LIMIT", show a]
  tosql (NoLimit) = ""

instance toSqlOffset :: ToSql Offset where
  tosql (Offset a) = join_ ["OFFSET", show a]
  tosql (NoOffset) = ""

instance toSqlAssign :: ToSql Assign where
  tosql (Assign c v) = join_ [c, "=", v]

instance toSqlUpdateValue :: ToSql UpdateValue where
  tosql (UpdateValue as) = join_ ["SET", join ", " $ map tosql (as ++ ["update_at" .= Now])]

instance toSqlInsertValue :: ToSql InsertValue where
  tosql (InsertValue as) = join_ ["(", cols, ")", "VALUES", "(", vals, ")"]
    where
      cols = join ", " $ fst cvs
      vals = join ", " $ snd cvs
      cvs = foldr (\(Assign c v) l -> Tuple (c:(fst l)) (v:(snd l))) (Tuple [] []) (as ++ ["create_at" .= Now, "update_at" .= Now])

instance toSqlSchema :: ToSql Schema where
  tosql (Schema as) = join ", " $ map toschema (as ++ ["create_at" .=> "DATETIME NOT NULL", "update_at" .=> "DATETIME NOT NULL", "id" .=> "INTEGER PRIMARY KEY AUTOINCREMENT"])
    where toschema (Assign col val) = join_ [col, val]

instance toSqlQuery :: ToSql Query where
  tosql (Find tn cs od lm off) = join_ $ ["SELECT * FROM", tn, tosql cs, tosql od, tosql lm, tosql off]
  tosql (First tn cs od) = join_ $ ["SELECT * FROM", tn, tosql cs, tosql od]
  tosql (Insert tn iv) = join_ $ ["INSERT INTO", tn, tosql iv]
  tosql (InsertOrUpdate tn iv) = join_ $ ["INSERT OR REPLACE INTO", tn, tosql iv]
  tosql (Update tn uv cs) = join_ $ ["UPDATE", tn, tosql uv, tosql cs]
  tosql (Delete tn cs) = join_ $ ["DELETE FROM", tn, tosql cs]
  tosql (Count tn cs) = join_ $ ["SELECT COUNT(*)", tn, tosql cs]
  tosql (CreateTable tn shm) = join_ $ ["CREATE TABLE IF NOT EXISTS", tn, "(", tosql shm, ")"]

-- Model Base

type ModelAff eff = DBAff (current::CURRENT | eff)

type Record t = Row ( id :: Int
                    , create_at :: DateTimeStr
                    , update_at :: DateTimeStr | t)

connect :: forall eff. ModelAff eff DB
connect = do
  path <- liftEff $ Config.database_path
  connectDB path default_mode

find :: forall eff t. Table -> Condition -> Order -> Limit -> Offset -> ModelAff eff (Array (Record t))
find tn cs od lm off = do
  db <- connect
  allDB db (tosql $ Find tn (ConditionSet cs) od lm off)

first :: forall eff t. Table -> Condition -> Order -> ModelAff eff (Record t)
first tn cs od = do
  db <- connect
  getDB db (tosql $ First tn (ConditionSet cs) od)

findall :: forall eff t. Table -> Condition -> Order -> ModelAff eff (Array (Record t))
findall tn cs od = do
  db <- connect
  allDB db (tosql $ Find tn (ConditionSet cs) od NoLimit NoOffset)

insert :: forall eff t. Table -> (Array Assign) -> ModelAff eff Unit
insert tn iv = do
  db <- connect
  runDB db (tosql $ Insert tn (InsertValue iv))

insertOrUpdate :: forall eff t. Table -> (Array Assign) -> ModelAff eff Unit
insertOrUpdate tn iv = do
  db <- connect
  runDB db (tosql $ InsertOrUpdate tn (InsertValue iv))

update :: forall eff t. Table -> (Array Assign) -> Condition -> ModelAff eff Unit
update tn uv cs = do
  db <- connect
  runDB db (tosql $ Update tn (UpdateValue uv) (ConditionSet cs))

delete :: forall eff t. Table -> Condition ->ModelAff eff Unit
delete tn cs = do
  db <- connect
  runDB db (tosql $ Delete tn (ConditionSet cs))

count :: forall eff. Table -> Condition -> ModelAff eff Int
count tn cs = do
  db <- connect
  result <- getDB db (tosql $ Count tn (ConditionSet cs))
  return result.count

createTable :: forall eff. Table -> Array Assign -> ModelAff eff Unit
createTable tn shm = do
  db <- connect
  runDB db (tosql $ CreateTable tn (Schema shm))
