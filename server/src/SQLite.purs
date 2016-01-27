module SQLite where

import Prelude
import Control.Monad.Cont.Trans
import Control.Monad.Except.Trans
import Data.Function
import Data.Either
import Control.Monad.Eff

type FilePath = String
type Sql = String
type Mode = Int
type ErrorMessage = String
type Row t = { id :: Int | t }

foreign import data DB :: *
foreign import data Stmt :: *
foreign import data DataBase :: *

foreign import memory_db :: FilePath
foreign import open_readonly_mode :: Mode
foreign import open_readwrite_mode :: Mode
foreign import open_create_mode :: Mode
foreign import default_mode :: Mode

foreign import connectImpl
-- foreign import connectImpl :: forall eff. Fn4 FilePath Mode
--                                 (DB -> Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)


-- foreign import closeImpl :: forall eff. Fn3 DB
--                                 (Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)

-- foreign import runImpl :: forall eff. Fn4 DB Sql
--                                 (Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)


-- foreign import getImpl :: forall eff t. Fn4 DB Sql
--                                 (Row t -> Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)


-- foreign import allImpl :: forall eff t. Fn4 DB Sql
--                                 (Array (Row t) -> Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)

-- foreign import eachImpl :: forall eff t. Fn4 DB Sql
--                                 (Row t -> Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)

-- foreign import execImpl :: forall eff. Fn4 DB Sql
--                                 (Eff eff Unit)
--                                 (ErrorCode -> Eff eff Unit)
--                                 (Eff eff Unit)

-- connect :: forall eff.
--              FilePath -> Mode ->
--              (Either ErrorCode DB -> Eff eff Unit) ->
--              (Eff eff Unit)
-- connect path mode k =
--   runFn4 connectImpl path mode (k <<< Right) (k <<< Left)

-- close :: forall eff.
--            DB ->
--            (Either ErrorCode Unit -> Eff eff Unit) ->
--            (Eff eff Unit)
-- close db k =
--   runFn3 closeImpl db (k $ Right unit) (k <<< Left)

-- run :: forall eff.
--        DB -> Sql ->
--        (Either ErrorCode Unit -> Eff eff Unit) ->
--        (Eff eff Unit)
-- run db sql k =
--   runFn4 runImpl db sql (k $ Right unit) (k <<< Left)

-- get :: forall eff t.
--        DB -> Sql ->
--        (Either ErrorCode (Row t) -> Eff eff Unit) ->
--        (Eff eff Unit)
-- get db sql k =
--   runFn4 getImpl db sql (k <<< Right) (k <<< Left)

-- all :: forall eff t.
--        DB -> Sql ->
--        (Either ErrorCode (Array (Row t)) -> Eff eff Unit) ->
--        (Eff eff Unit)
-- all db sql k =
--   runFn4 allImpl db sql (k <<< Right) (k <<< Left)

-- each :: forall eff t.
--        DB -> Sql ->
--        (Either ErrorCode (Row t) -> Eff eff Unit) ->
--        (Eff eff Unit)
-- each db sql k =
--   runFn4 eachImpl db sql (k <<< Right) (k <<< Left)

-- exec :: forall eff.
--        DB -> Sql ->
--        (Either ErrorCode Unit -> Eff eff Unit) ->
--        (Eff eff Unit)
-- exec db sql k =
--   runFn4 execImpl db sql (k $ Right unit) (k <<< Left)

-- type Async eff = ContT Unit (Eff eff)

-- runAsync :: forall eff t. Async eff t -> (t -> Eff eff Unit) -> Eff eff Unit
-- runAsync cont = runContT cont

-- connectCont :: forall eff.
--                FilePath -> Mode -> Async eff (Either ErrorCode DB)
-- connectCont path mode = ContT $ connect path mode

-- closeCont :: forall eff.
--              DB -> Async eff (Either ErrorCode Unit)
-- closeCont db = ContT $ close db

-- runCont :: forall eff.
--        DB -> Sql -> Async eff (Either ErrorCode Unit)
-- runCont db sql = ContT $ run db sql

-- getCont :: forall eff t.
--        DB -> Sql -> Async eff (Either ErrorCode (Row t))
-- getCont db sql = ContT $ get db sql

-- allCont :: forall eff t.
--        DB -> Sql -> Async eff (Either ErrorCode (Array (Row t)))
-- allCont db sql = ContT $ all db sql

-- eachCont :: forall eff t.
--        DB -> Sql -> Async eff (Either ErrorCode (Row t))
-- eachCont db sql = ContT $ each db sql

-- execCont :: forall eff.
--        DB -> Sql -> Async eff (Either ErrorCode Unit)
-- execCont db sql = ContT $ exec db sql


-- runAsyncEx :: forall eff t.
--               ExceptT ErrorCode (Async eff) t -> (Either ErrorCode t -> Eff eff Unit) -> Eff eff Unit
-- runAsyncEx contex next = runContT (runExceptT contex) next

-- connectContEx :: forall eff.
--                FilePath -> Mode -> ExceptT ErrorCode (Async eff) DB
-- connectContEx path mode = ExceptT $ connectCont path mode

-- closeContEx :: forall eff.
--              DB -> ExceptT ErrorCode (Async eff) Unit
-- closeContEx db = ExceptT $ closeCont db

-- runContEx :: forall eff.
--        DB -> Sql -> ExceptT ErrorCode (Async eff) Unit
-- runContEx db sql = ExceptT $ runCont db sql

-- getContEx :: forall eff t.
--        DB -> Sql -> ExceptT ErrorCode (Async eff) (Row t)
-- getContEx db sql = ExceptT $ getCont db sql

-- allContEx :: forall eff t.
--        DB -> Sql -> ExceptT ErrorCode (Async eff) (Array (Row t))
-- allContEx db sql = ExceptT $ allCont db sql

-- eachContEx :: forall eff t.
--        DB -> Sql -> ExceptT ErrorCode (Async eff) (Row t)
-- eachContEx db sql = ExceptT $ eachCont db sql

-- execContEx :: forall eff.
--        DB -> Sql -> ExceptT ErrorCode (Async eff) Unit
-- execContEx db sql = ExceptT $ execCont db sql
