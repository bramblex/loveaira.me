module Lib.CookieSession where

import Prelude
import Control.Monad.Eff.Class
import Data.Function
import Node.Express.Types
import Node.Express.Handler

import Data.Foreign.NullOrUndefined
import Data.Foreign
import Data.Foreign.Class
import Data.Maybe
import Data.Either

import qualified Lib.Utils as Utils

foreign import cookieSession ::
  forall eff t. {| t } -> Fn3 Request Response (ExpressM eff Unit) (ExpressM eff Unit)

sessionSet :: forall eff a. (IsForeign a) => String -> a -> Handler eff
sessionSet k v = HandlerM $ \req _ _ ->
  liftEff $ runFn3 _sessionSet req k (toForeign v)

sessionGet :: forall eff a. (IsForeign a) => String -> HandlerM (express::EXPRESS | eff) (Maybe a)
sessionGet k = HandlerM $ \req _ _ ->
  liftEff $ do
    r <- runFn2 _sessionGet req k
    return $ Utils.eitherToMaybe <<< read $ r

sessionClear :: forall eff. String -> Handler eff
sessionClear k = HandlerM $ \req _ _ ->
  liftEff $ runFn2 _sessionClear req k

sessionClearAll :: forall eff. Handler eff
sessionClearAll = HandlerM $ \req _ _ ->
  liftEff $ runFn1 _sessionClearAll req

foreign import _sessionSet ::
  forall eff. Fn3 Request String Foreign (ExpressM eff Unit)

foreign import _sessionGet ::
  forall eff. Fn2 Request String (ExpressM eff Foreign)

foreign import _sessionClear ::
  forall eff. Fn2 Request String (ExpressM eff Unit)

foreign import _sessionClearAll ::
  forall eff. Fn1 Request (ExpressM eff Unit)

-- import Data.Foreign
-- import Data.Foreign.Class

type SimpleUser t = {id :: Int, username :: String, role :: String | t}
newtype SessionUser = SessionUser (SimpleUser ())

toSessionUser user = SessionUser {id: user.id, username: user.username, role: user.role}

-- class isSessionUser :: IsSessionUser a where
--   toSessionUser :: a -> SessionUser

instance sessionuUerIsForeign :: IsForeign SessionUser where
  read value = do
    id <- readProp "id" value
    username <- readProp "username" value
    role <- readProp "role" value
    return $ SessionUser {id: id, username: username, role: role}

newtype Session = Session { is_logined :: Boolean
               , user :: Maybe (SimpleUser ())}

empty_session = Session {is_logined: false, user : Nothing}
