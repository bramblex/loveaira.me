module Database.SQLite.SQLiteImpl where

import Prelude
import Data.Function
import Control.Monad.Eff

import Control.Monad.Error.Class
import Control.Monad.Eff.Exception

import Database.SQLite.Type

foreign import connectDBImpl ::
  forall eff. Fn4 FilePath Mode
  (Error -> DBEff eff Unit)
  (DB -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import closeDBImpl ::
  forall eff t. Fn3 DB
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import runDBImpl ::
  forall eff t. Fn4 DB Sql
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import runDB1Impl ::
  forall eff t. Fn5 DB Sql ParamList
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import runDB2Impl ::
  forall eff a t. Fn5 DB Sql (ParamMap a)
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import getDBImpl ::
  forall eff t. Fn4 DB Sql
  (Error -> DBEff eff Unit)
  (Row t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import getDB1Impl ::
  forall eff t. Fn5 DB Sql ParamList
  (Error -> DBEff eff Unit)
  (Row t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import getDB2Impl ::
  forall eff t a. Fn5 DB Sql (ParamMap a)
  (Error -> DBEff eff Unit)
  (Row t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import allDBImpl ::
  forall eff t. Fn4 DB Sql
  (Error -> DBEff eff Unit)
  (Array (Row t) -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import allDB1Impl ::
  forall eff t. Fn5 DB Sql ParamList
  (Error -> DBEff eff Unit)
  (Array (Row t) -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import allDB2Impl ::
  forall eff t a. Fn5 DB Sql (ParamMap a)
  (Error -> DBEff eff Unit)
  (Array (Row t) -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import eachDBImpl ::
  forall eff t a. Fn5 DB Sql (Row t -> Eff eff Unit)
  (Error -> DBEff eff Unit)
  (a -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import eachDB1Impl ::
  forall eff t a. Fn6 DB Sql ParamList (Row t -> Eff eff Unit)
  (Error -> DBEff eff Unit)
  (a -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import eachDB2Impl ::
  forall eff t a b. Fn6 DB Sql (ParamMap a) (Row t -> Eff eff Unit)
  (Error -> DBEff eff Unit)
  (b -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import execDBImpl ::
  forall t eff. Fn4 DB Sql
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import execDB1Impl ::
  forall t eff. Fn5 DB Sql ParamList
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)

foreign import execDB2Impl ::
  forall eff t a. Fn5 DB Sql (ParamMap a)
  (Error -> DBEff eff Unit)
  (t -> DBEff eff Unit)
  (DBEff eff Unit)
