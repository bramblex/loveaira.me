module Lib.Middleware where

import Prelude
import Data.Function
import Control.Monad.Eff.Class
import Node.Express.Types
import Node.Express.Handler

foreign import bodyParser :: forall e t. {|t} -> Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)

foreign import static :: forall e t. Path -> Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)

foreign import  setCookiesMaxAge  :: forall e. Int -> Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)

foreign import _githubWebhockHandler :: forall e. Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)

githubWebhockHandler :: forall e. HandlerM (express::EXPRESS|e) Unit
githubWebhockHandler = HandlerM $ \req res next ->
  liftEff $ runFn3 _githubWebhockHandler req res next

