module SQLite where

import Prelude
import Control.Monad.Eff
-- import Data.Function
-- import Control.Monad.Eff.Console

import Control.Monad.Cont.Trans
import Control.Monad.Except.Trans
import Data.Either

import SQLiteImpl
import FnImpl

type Async eff t = ExceptT Error (ContT Unit (Eff eff)) t
type DBAsync eff t = Async (database :: DATABASE | eff) t

mkAsync :: forall eff t.
           ((Either Error t -> Eff eff Unit) -> Eff eff Unit) -> Async eff t
mkAsync = ExceptT <<< ContT

runAsync :: forall eff t.
            Async eff t -> (Either Error t -> Eff eff Unit) -> Eff eff Unit
runAsync cont next = runContT (runExceptT cont) next


connectDB :: forall eff. FilePath -> Mode -> DBAsync eff DB
connectDB path mode =  mkAsync $ runFn4Impl connectDBImpl path mode


closeDB :: forall eff. DB -> DBAsync eff Unit
closeDB db = mkAsync $ runFn3Impl' closeDBImpl db


runDB :: forall eff. DB -> Sql -> DBAsync eff Unit
runDB db sql = mkAsync $ runFn4Impl' runDBImpl db sql

runDB1 :: forall eff. DB -> Sql -> ParamList -> DBAsync eff Unit
runDB1 db sql params = mkAsync $ runFn5Impl' runDB1Impl db sql params

runDB2 :: forall eff p. DB -> Sql -> ParamMap p -> DBAsync eff Unit
runDB2 db sql params = mkAsync $ runFn5Impl' runDB2Impl db sql params


getDB :: forall eff t. DB -> Sql -> DBAsync eff (Row t)
getDB db sql = mkAsync $ runFn4Impl getDBImpl db sql

getDB1 :: forall eff t. DB -> Sql -> ParamList -> DBAsync eff (Row t)
getDB1 db sql params = mkAsync $ runFn5Impl getDB1Impl db sql params

getDB2 :: forall eff a t. DB -> Sql -> ParamMap a -> DBAsync eff (Row t)
getDB2 db sql params = mkAsync $ runFn5Impl getDB2Impl db sql params


allDB :: forall eff t. DB -> Sql -> DBAsync eff (Array (Row t))
allDB db sql = mkAsync $ runFn4Impl allDBImpl db sql

allDB1 :: forall eff t. DB -> Sql -> ParamList -> DBAsync eff (Array (Row t))
allDB1 db sql params = mkAsync $ runFn5Impl allDB1Impl db sql params

allDB2 :: forall eff a t. DB -> Sql -> ParamMap a -> DBAsync eff (Array (Row t))
allDB2 db sql params = mkAsync $ runFn5Impl allDB2Impl db sql params


eachDB :: forall eff t. DB -> Sql -> (Row t -> Eff eff Unit) -> DBAsync eff Unit
eachDB db sql callback = mkAsync $ runFn5Impl' eachDBImpl db sql callback

eachDB1 :: forall eff t. DB -> Sql -> ParamList -> (Row t -> Eff eff Unit) -> DBAsync eff Unit
eachDB1 db sql params callback = mkAsync $ runFn6Impl' eachDB1Impl db sql params callback

eachDB2 :: forall eff a t. DB -> Sql -> ParamMap a -> (Row t -> Eff eff Unit) -> DBAsync eff Unit
eachDB2 db sql params callback = mkAsync $ runFn6Impl' eachDB2Impl db sql params callback

execDB :: forall eff. DB -> Sql -> DBAsync eff Unit
execDB db sql = mkAsync $ runFn4Impl' execDBImpl db sql

execDB1 :: forall eff. DB -> Sql -> ParamList -> DBAsync eff Unit
execDB1 db sql params = mkAsync $ runFn5Impl' execDB1Impl db sql params

execDB2 :: forall eff p. DB -> Sql -> ParamMap p -> DBAsync eff Unit
execDB2 db sql params = mkAsync $ runFn5Impl' execDB2Impl db sql params
