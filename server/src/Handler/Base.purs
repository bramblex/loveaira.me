module Handler.Base ( module Handler.Base
                    , module Prelude
                    , module Data.Maybe
                    , module Data.Tuple
                    , module Control.Monad.Aff.Class
                    , module Node.Express.Types
                    , module Node.Express.Handler
                    , module Node.Express.Request
                    , module Node.Express.App
                    , module Node.Express.Response) where

import Prelude hiding (apply)
import Node.Express.App
import Node.Express.Types
import Node.Express.Handler
import Node.Express.Request
import Node.Express.Response
import Control.Monad.Aff.Class
import Data.Maybe
import Data.Tuple


import Control.Monad.Eff

import Database.SQLite.Type
import Lib.Utils

import qualified Data.DOM.Render as R
render = send <<< R.render

-- type
type ModelHandlerM eff = HandlerM (database::DATABASE, current::CURRENT, express::EXPRESS | eff)

type HandlerEff eff a = Eff (database::DATABASE, current::CURRENT, express::EXPRESS | eff) a

type ModelHandler eff = ModelHandlerM eff Unit

type ModelApp eff = App (database::DATABASE, current::CURRENT | eff)
