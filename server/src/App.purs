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

main :: forall e. App (console :: CONSOLE | e)
main = do
  liftEff $ log "Setting up"
  setProp "json spaces" 4.0
  useExternal $ cookieSession {secret: Config.security_key}
  mount "/subapp" subapp

-- main =

-- indexHandler :: forall e. AppState -> Handler e
-- indexHandler _ = do
--   sendJson help

-- import Lib.CookieSession
-- import Config

-- subAppIndexHandler :: forall eff. Handler eff
-- subAppIndexHandler = do
--   send "This is subapp"

-- setSessionHandler :: forall eff. Handler eff
-- setSessionHandler = do
--   sessionSet "user" {info: "something"}
--   send "set session test: "

-- getSessionHandler :: forall eff. Handler eff
-- getSessionHandler = do
--   user <- sessionGet "user"
--   send $ "session test: " ++ user.info

-- subapp :: forall eff. App eff
-- subapp = do
--   get "/" subAppIndexHandler
--   get "/set" setSessionHandler
--   get "/get" getSessionHandler


  -- get "/set" setSessionHandler
  -- get "/get" getSessionHandler

  -- use               (logger            state)
  -- get "/"           (indexHandler      state)
  -- get "/list"       (listTodosHandler  state)
  -- get "/create"     (createTodoHandler state)
  -- get "/update/:id" (updateTodoHandler state)
  -- get "/delete/:id" (deleteTodoHandler state)
  -- get "/done/:id"   (doTodoHandler     state)
  -- useOnError        (errorHandler      state)

-- foreign import _mount ::
--   forall eff. Fn3 Application String Application (Eff (express :: EXPRESS | eff) Unit)

-- mount :: forall eff. Path -> App eff -> App eff
-- mount mountpath (AppM subact) = AppM \app -> do
--   subapp <- mkApplication
--   subact subapp
--   runFn3 app mountpath subapp
