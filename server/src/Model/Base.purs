module Model.Base where

import Prelude
-- import Data.Foldable
-- import Control.Monad
-- import Control.Monad.Trans
-- import Control.Monad.Reader
-- import Control.Monad.Reader.Trans

-- import Control.Monad.Eff
-- import Control.Monad.Cont.Trans
-- import Control.Monad.Except.Trans
-- import Data.Either
-- import Control.Monand.Reader

import Database.SQLite

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

instance relationSetR :: Relation SetR where
  (.&&) r c = SAnd r c
  (.||) r c = r .&& c

instance relationValueR :: Relation ValueR where
  (.&&) r c = VAnd r c
  (.||) r c = r .&& c

data Order = Asc | Desc
data OrderBy = OrderBy Column Order

data Qurey = Find Table Conditions OrderBy
           | Insert Table Value
           | Update Table Set Conditions
           | Delete Table Conditions

class ToSql f where
  tosql :: f -> Sql

instance toSqlOrderBy :: ToSql OrderBy where
  tosql (OrderBy col o) =
    "ORDER BY " ++ col ++ " " ++
    case o of
      Asc -> "ASC"
      Desc -> "DESC"

instance toSqlCondition :: ToSql Condition where
  tosql c = case c of
    Eq col v -> col ++ "=" ++ v
    Gt col v -> col ++ ">" ++ v
    Gte col v -> col ++ ">=" ++ v
    Lt col v -> col ++ "<" ++ v
    Lte col v -> col ++ "<=" ++ v

-- instance toSqlConditions :: ToSql Conditions where
-- tosql cs = case cs of
--   Where c -> "WHERE " ++ tosql c
--   CAnd cs c -> tosql cs ++ " AND " ++ tosql c
--   COr cs c -> tosql cs ++ " OR " ++ tosql c

-- instance toSqlQuery :: ToSql Qurey where
--   tosql (Find table condistions order)

-- qurey :: Qurey
-- qurey = Insert
--         "name"
--         (Value ("name" .= "qiao") .&& ("role" .= "admin"))
-- qurey = Find "name" (Where ("id" .> 10) .&& ("role" .= "admin")) (OrderBy "id" Dsec)

-- runQurey :: forall eff t. Qurey -> Async eff f
-- runQurey  =

-- qurey :: forall t. Qurey t
-- qurey = Find "User"
--   (Where ("id" .< "100") .|| ("role" .= "admin")) (OrderBy "score" Dsec)

-- mksql :: forall t. Qurey t -> Sql
-- mksql qurey = case qurey of
--   FindQurey table conditions orderby ->
--     "FROM " ++ table ++ " WHERE " ++ show conditions ++ " " ++ show orderby

-- find :: forall eff t. TableName -> Conditions -> DBAsync eff (Record t)
-- find tablename conditions
-- type Async eff t = ExceptT Error (ContT Unit (Eff eff)) t -- type WithDB eff t = ReaderT DB (DBAsync eff) t

-- type WithDB eff t = Reader DB (DBAsync eff t)

-- runWithDB :: forall eff t. FilePath -> WithDB eff t -> DBAsync eff t
-- runWithDB path withdb = do
--   db <- connectDB path default_mode
--   runReader withdb db

-- find :: forall eff t. Sql -> WithDB eff (Array (Record t))
-- find sql = do
--   db <- ask
--   return $ allDB db sql

-- runtest path cont next = runAsync cont' next
--   where cont' = do
--           db <- connectDB path
--           runWithDB db cont

-- runWithDB path async_op next = runAsync async_op_with_db next
--   where async_op_with_db = do
--           db <- connectDB path
--           runReader db async_op

-- runWithDB :: forall eff t. DB -> Sql ->
-- runWithDB :: forall eff. Sql -> WithDB eff Unit
-- runWithDB sql = ReaderT $ \(db, r) -> (db, runDB db sql)

-- findtest :: forall eff. WithDB eff Unit
-- findtest = do
--   db <- lift ask
--   ReaderT $ \db -> runDB db "aaa"

-- withDB :: forall eff t. DB -> (DB -> Async eff t) -> WithDB eff t
-- withDB db cont = do
  -- cont db

-- withDB :: DB -> Reader BD Unit

-- find :: forall t. DB -> TableName -> Condition -> Record t
-- find
--   condition
--     order

-- save :: forall t. DB -> TableName -> Record t -> Unit

-- insert :: forall t. DB -> TableName -> Record t -> Unit
-- insert

-- update :: forall t. DB -> TableName -> OP -> Condition -> Unit
--   condition

-- delete :: forall t. DB -> TableName ->
--   condition
