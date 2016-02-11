module Lib.CookieSession where

import Prelude
import Control.Monad.Eff.Class
import Data.Function
import Node.Express.Types
import Node.Express.Handler

foreign import cookieSession ::
  forall eff t. {| t } -> Fn3 Request Response (ExpressM eff Unit) (ExpressM eff Unit)

sessionSet :: forall eff t. String -> t -> Handler eff
sessionSet k v = HandlerM $ \req _ _ ->
  liftEff $ runFn3 _sessionSet req k v

sessionGet :: forall eff t. String -> HandlerM (express::EXPRESS | eff) t
sessionGet k = HandlerM $ \req _ _ ->
  liftEff $ runFn2 _sessionGet req k

foreign import _sessionSet ::
  forall eff t. Fn3 Request String t (ExpressM eff Unit)

foreign import _sessionGet ::
  forall eff t. Fn2 Request String (ExpressM eff t)
