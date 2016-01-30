module Database.SQLite.SQLiteImpl where

import Prelude
import Data.Function
import Control.Monad.Eff

type FilePath = String
type Sql = String
type Mode = Int
type Error = { errno :: Int, code :: String, message :: String }
type Row t = { | t }
type Param = String
type ParamList = Array Param
type ParamMap t = { | t }

foreign import data DB :: *
foreign import data DATABASE :: !
type DBEff eff = Eff (database :: DATABASE | eff)

foreign import memory_db :: FilePath
foreign import open_readonly_mode :: Mode
foreign import open_readwrite_mode :: Mode
foreign import open_create_mode :: Mode
foreign import default_mode :: Mode

foreign import connectDBImpl ::
  forall eff. Fn4 FilePath Mode
  (DB -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import closeDBImpl ::
  forall eff. Fn3 DB
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import runDBImpl ::
  forall eff. Fn4 DB Sql
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import runDB1Impl ::
  forall eff. Fn5 DB Sql ParamList
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import runDB2Impl ::
  forall eff a. Fn5 DB Sql (ParamMap a)
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import getDBImpl ::
  forall eff t. Fn4 DB Sql
  (Row t -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import getDB1Impl ::
  forall eff t. Fn5 DB Sql ParamList
  (Row t -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import getDB2Impl ::
  forall eff t a. Fn5 DB Sql (ParamMap a)
  (Row t -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import allDBImpl ::
  forall eff t. Fn4 DB Sql
  (Array (Row t) -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import allDB1Impl ::
  forall eff t. Fn5 DB Sql ParamList
  (Array (Row t) -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import allDB2Impl ::
  forall eff t a. Fn5 DB Sql (ParamMap a)
  (Array (Row t) -> DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import eachDBImpl ::
  forall eff t. Fn5 DB Sql (Row t -> Eff eff Unit)
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import eachDB1Impl ::
  forall eff t. Fn6 DB Sql ParamList (Row t -> Eff eff Unit)
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import eachDB2Impl ::
  forall eff t a. Fn6 DB Sql (ParamMap a) (Row t -> Eff eff Unit)
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import execDBImpl ::
  forall eff. Fn4 DB Sql
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import execDB1Impl ::
  forall eff. Fn5 DB Sql ParamList
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import execDB2Impl ::
  forall eff a. Fn5 DB Sql (ParamMap a)
  (DBEff eff Unit)
  (Error -> DBEff eff Unit)
  (DBEff eff Unit)
