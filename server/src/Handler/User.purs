module Handler.User where

import Data.Maybe
import Data.Tuple
import Handler.Base
import qualified Template.User as T
import qualified Model.User as M
import Lib.CookieSession

import qualified Lib.Utils as Utils

main :: forall eff. ModelApp eff
main = do
  get "/" $ redirect "/status"
  all "/login" login
  get "/logout" logout
  get "/status" $ requireLogin status
  all "/changePassword" $ requireLogin changePassword

login :: forall eff. ModelHandler eff
login = do
  method <- getMethod
  case method of
    Just GET -> render $ T.login Nothing
    Just POST -> do
      Tuple (username :: Maybe String) (password :: Maybe String) <- Tuple <$> getBodyParam "username" <*> getBodyParam "password"
      result <- liftAff $ M.authorization username password
      case result of
        Just user -> do
          sessionLogin user
          redirectBack
        Nothing -> render $ T.login $ Just "Wrong username or password!"
    _ -> next

logout :: forall eff. ModelHandler eff
logout = do
  sessionLogout
  redirectBack

status :: forall eff. ModelHandler eff
status =  do
  user <- currentUser
  render $ T.status user

changePassword :: forall eff. ModelHandler eff
changePassword = do
  method <- getMethod
  case method of
    Just GET -> do
      user <- currentUser
      render $ T.changePassword user Nothing
    Just POST -> do
      user <- currentUser
      password :: Maybe String <- getBodyParam "password"
      result <- liftAff $ M.authorization (Just user.username) password
      case result of
        Nothing -> render $ T.changePassword user $ Just "Wrong Password!"
        Just _ -> do
          Tuple (newpassword :: Maybe String) (repeated :: Maybe String) <- Tuple <$> getBodyParam "newpassword" <*> getBodyParam "repeated"
          success <- liftAff $ M.changePassword user.id newpassword repeated
          case success of
            true -> redirect "/user/status"
            false -> render $ T.changePassword user $ Just "Wrong New Password!"
    _ -> next

requireLogin :: forall eff. ModelHandler eff -> ModelHandler eff
requireLogin handler = do
  is_login <- isLogin
  case is_login of
    true -> handler
    false -> do
      url <- getOriginalUrl
      redirect $ "/user/login?url=" ++ Utils.encodeURIComponent url

requireAdmin :: forall eff. ModelHandler eff -> ModelHandler eff
requireAdmin handler = requireLogin $ do
  user <- currentUser
  case user.role of
    "admin" -> handler
    _ -> render $ T.login $ Just "Access Denied!"

redirectBack :: forall eff. ModelHandler eff
redirectBack  = do
  r <- getQueryParam "url"
  case r of
    Just url -> redirect $ Utils.decodeURIComponent url
    _ -> redirect "/"

import Model.User (SimpleUser(), SessionUser(..), toSessionUser)

sessionLogin :: forall eff t. SimpleUser t -> ModelHandler eff
sessionLogin user = do
  sessionSet "is_login" true
  sessionSet "current_user" (toSessionUser user)

sessionLogout :: forall eff. ModelHandler eff
sessionLogout = do
  sessionSet "is_login" false
  sessionClear "current_user"
