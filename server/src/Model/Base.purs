module Model.Base where

import Prelude
import Data.Foldable
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.Reader.Trans

-- import Control.Monad.Eff
-- import Control.Monad.Cont.Trans
-- import Control.Monad.Except.Trans
-- import Data.Either
-- import Control.Monand.Reader

import Database.SQLite

-- type Date = String
-- type Record t = Row ( id :: Int, create_at :: Date, update_at :: Date | t )

-- type Table = String
-- type Column = String
-- type Value = String

-- data Condition = Eq Column Value
--                | Gt Column Value
--                | Gte Column Value
--                | Lt Column Value
--                | Lte Column Value

-- (.=) :: Column -> Value -> Condition
-- (.=) c v = Eq c v

-- (.>) :: Column -> Value -> Condition
-- (.>) c v = Gt c v

-- (.<) :: Column -> Value -> Condition
-- (.<) c v = Lt c v

-- (.>=) :: Column -> Value -> Condition
-- (.>=) c v = Gte c v

-- (.<=) :: Column -> Value -> Condition
-- (.<=) c v = Lte c v

-- data Conditions = And Conditions Condition
--                 | Or Conditions Condition
--                 | Where Condition


-- (.&&) :: Conditions -> Condition -> Conditions
-- (.&&) cs c = And cs c

-- (.||) :: Conditions -> Condition -> Conditions
-- (.||) cs c = Or cs c

-- data Order = Asec | Dsec
-- data OrderBy = OrderBy Column Order

-- newtype Set = Set (Array Condition)
-- newtype Value = Value (Array Condition)

-- data Qurey t = Find Table Conditions OrderBy
--              | Insert Table Value
--              | Update Table Set Conditions
--              | Delete Table Conditions

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
