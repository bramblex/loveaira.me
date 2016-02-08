module Database.SQLite
       (module Database.SQLite.Type
       ,module Database.SQLite)
       where

import Prelude
import Data.Function
import Control.Monad.Eff
import Control.Monad.Aff

import Database.SQLite.Type
import Database.SQLite.SQLiteImpl

type DBAff eff = Aff (database::DATABASE | eff)

connectDB :: forall eff. FilePath -> Mode -> DBAff eff DB
connectDB path mode =  makeAff $ runFn4 connectDBImpl path mode


closeDB :: forall eff. DB -> DBAff eff Unit
closeDB db = makeAff $ runFn3 closeDBImpl db


runDB :: forall eff. DB -> Sql -> DBAff eff Unit
runDB db sql = makeAff $ runFn4 runDBImpl db sql

runDB1 :: forall eff. DB -> Sql -> ParamList -> DBAff eff Unit
runDB1 db sql params = makeAff $ runFn5 runDB1Impl db sql params

runDB2 :: forall eff p. DB -> Sql -> ParamMap p -> DBAff eff Unit
runDB2 db sql params = makeAff $ runFn5 runDB2Impl db sql params


getDB :: forall eff t. DB -> Sql -> DBAff eff (Row t)
getDB db sql = makeAff $ runFn4 getDBImpl db sql

getDB1 :: forall eff t. DB -> Sql -> ParamList -> DBAff eff (Row t)
getDB1 db sql params = makeAff $ runFn5 getDB1Impl db sql params

getDB2 :: forall eff a t. DB -> Sql -> ParamMap a -> DBAff eff (Row t)
getDB2 db sql params = makeAff $ runFn5 getDB2Impl db sql params


allDB :: forall eff t. DB -> Sql -> DBAff eff (Array (Row t))
allDB db sql = makeAff $ runFn4 allDBImpl db sql

allDB1 :: forall eff t. DB -> Sql -> ParamList -> DBAff eff (Array (Row t))
allDB1 db sql params = makeAff $ runFn5 allDB1Impl db sql params

allDB2 :: forall eff a t. DB -> Sql -> ParamMap a -> DBAff eff (Array (Row t))
allDB2 db sql params = makeAff $ runFn5 allDB2Impl db sql params


eachDB :: forall eff t. DB -> Sql -> (Row t -> Eff eff Unit) -> DBAff eff Unit
eachDB db sql callback = makeAff $ runFn5 eachDBImpl db sql callback

eachDB1 :: forall eff t. DB -> Sql -> ParamList -> (Row t -> Eff eff Unit) -> DBAff eff Unit
eachDB1 db sql params callback = makeAff $ runFn6 eachDB1Impl db sql params callback

eachDB2 :: forall eff a t. DB -> Sql -> ParamMap a -> (Row t -> Eff eff Unit) -> DBAff eff Unit
eachDB2 db sql params callback = makeAff $ runFn6 eachDB2Impl db sql params callback


execDB :: forall eff. DB -> Sql -> DBAff eff Unit
execDB db sql = makeAff $ runFn4 execDBImpl db sql

execDB1 :: forall eff. DB -> Sql -> ParamList -> DBAff eff Unit
execDB1 db sql params = makeAff $ runFn5 execDB1Impl db sql params

execDB2 :: forall eff p. DB -> Sql -> ParamMap p -> DBAff eff Unit
execDB2 db sql params = makeAff $ runFn5 execDB2Impl db sql params
