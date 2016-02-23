module Lib.Cache where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Data.Function
import Node.Express.Types
import Node.Express.Handler

import Data.Foreign.NullOrUndefined
import Data.Foreign
import Data.Foreign.Class
import Data.Maybe
import Data.Either

import Lib.Utils

foreign import _cache
  :: forall eff. Fn3 Int String String (Eff (current::CURRENT | eff) Unit)

foreign import _getCached
  :: forall eff. Fn1 String (Eff (current::CURRENT | eff) Foreign)

foreign import _cleanCached
  :: forall eff. Fn0 (Eff (current::CURRENT | eff) Unit)

cache :: forall eff. Int -> String -> String -> Eff (current::CURRENT | eff) Unit
cache = runFn3 _cache

cleanCached :: forall eff. Eff (current::CURRENT | eff) Unit
cleanCached = runFn0 _cleanCached

getCached :: forall eff. String -> Eff (current::CURRENT | eff) (Maybe String)
getCached key = do
  r <- runFn1 _getCached key
  return $ eitherToMaybe <<< read $ r
