module Main where

import Prelude hiding (append)

import Control.Monad.Eff
import Control.Monad.Eff.Exception
import Control.Monad.Eff.Class
import Control.Monad.Eff.Console (log)

import Control.Monad.Eff.JQuery
import Data.Maybe

import Control.Monad.Aff
import Control.Monad.Aff.Class
import Network.HTTP.Affjax
import Network.HTTP.StatusCode
import Network.HTTP.ResponseHeader

import DOM

import qualified Data.Foldable as F

findRedirectUrl :: Array ResponseHeader -> String
findRedirectUrl headers =
  unwaper $ F.find (\h -> responseHeaderName h == "Location") headers
    where unwaper (Just h) = responseHeaderValue h

main = ready do
  -- buttom <- select "a[data-delete]"
  -- void $ on "click" (deleteArticleHandler) buttom
  on "click" (deleteArticleHandler) <$> select "a[data-delete]"
  menuLink <- select ".toggle-menu"
  void $ on "click" (menuLinkHandler) menuLink

menuLinkHandler e el = do
  preventDefault e
  layout <- select "#layout"
  menu <- select "#menu"
  toggleClass "active" layout
  toggleClass "active" menu
  toggleClass "active" el

deleteArticleHandler e el = do
  href <- getAttr "data-delete" el
  redirect_url <- getAttr "data-redirect" el
  checed <- confirm $ "Are you sure to run this command " ++ href
  log $ show checed
  case checed of
    true -> launchAff $ do
      liftEff $ log $ href ++ " " ++ redirect_url
      res <- post href ""
      case res.status of
        StatusCode 200 -> do
          let cont = res.response ++ ""
          case redirect_url of
            "" -> liftEff $ refresh
            url -> liftEff $ redirect url
        _ -> liftEff $ alert "Delete Error!"
    fase -> return unit


foreign import data MAIN :: !
foreign import refresh :: forall eff. Eff (main::MAIN | eff) Unit
foreign import redirect :: forall eff. String -> Eff (main::MAIN | eff) Unit

foreign import confirm :: forall eff. String -> Eff (main::MAIN | eff) Boolean
foreign import alert :: forall eff. String -> Eff (main::MAIN | eff) Unit
