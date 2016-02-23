module App where

import Prelude hiding (apply)
import Data.Maybe
import Data.Either
import Data.Int
import Data.Function
import Data.Array    as A
import Data.Foldable (foldl)
import Data.Foreign.EasyFFI
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Console (CONSOLE(), log, print)
import Control.Monad.Eff.Exception
import Node.Express.Types
import Node.Express.App
import Node.Express.Handler
import Node.Express.Request
import Node.Express.Response
import Node.HTTP (Server())

import Lib.CookieSession
import qualified Config as Config

import qualified Lib.Middleware as MW
import qualified Lib.Utils as Utils
import qualified Template.Base as T

import qualified Handler.User as UserHandler
import qualified Handler.Article as ArticleHandler
import qualified Handler.Category as CategoryHandler
import qualified Handler.Home as HomeHandler
import qualified Handler.Cache as CacheHandler

import Handler.Base

main :: forall e. ModelApp (console :: CONSOLE | e)
main = do
  liftEff $ log "Setting up"
  setProp "json spaces" 4.0

  useExternal $ MW.bodyParser {extended: false}
  static_path <- liftEff $ Config.static_path
  useExternalAt "/static" $ MW.static static_path

  useExternal $ cookieSession {secret: Config.security_key}
  useExternal $ MW.setCookiesMaxAge (3600 * 24 * 30)

  use CacheHandler.logger
  use CacheHandler.cacheMiddleware

  mount "/" HomeHandler.main

  mount "/user" UserHandler.main
  mount "/article" ArticleHandler.main
  mount "/category" CategoryHandler.main
  mount "/cache" CacheHandler.main

  -- use $ redirect "/"
