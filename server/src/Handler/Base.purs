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

import Template.Base (Template())

infix 5 .<=
(.<=) :: Template -> Template -> Template
(.<=) a b = a >>= (\_ -> b)

-- type
type ModelHandlerM eff = HandlerM (database::DATABASE, current::CURRENT, express::EXPRESS | eff)

type HandlerEff eff a = Eff (database::DATABASE, current::CURRENT, express::EXPRESS | eff) a

type ModelHandler eff = ModelHandlerM eff Unit

type ModelApp eff = App (database::DATABASE, current::CURRENT | eff)


-- import Model.User (SimpleUser(), SessionUser(..), toSessionUser)
import Lib.CookieSession

isLogin :: forall eff. ModelHandlerM eff Boolean
isLogin = do
  is_login :: Maybe Boolean <- sessionGet "is_login"
  case is_login of
    Just true -> return true
    _ -> return false

currentUser :: forall eff. ModelHandlerM eff (SimpleUser ())
currentUser = do
  (Just (SessionUser user)) <- sessionGet "current_user"
  return user

import qualified Data.DOM.Render as R
import qualified Template.Base as T

-- render = send <<< R.render


-- import
import Lib.CookieSession (Session(..), empty_session)

render :: forall eff. Template -> ModelHandler eff
render cont = do
  is_logined <- isLogin
  case is_logined of
    false -> send <<< R.render empty_session $ cont
    true -> do
      user <- currentUser
      send <<< R.render (Session { is_logined: true , user: Just user}) $ cont

  -- is_logined <- isLogin
  -- case is_logined of
  --   false -> send <<< R.render $ cont
  --   true -> do
  --     user <- currentUser
  --     send <<< R.render $ cont .<= T.loginedUser user
