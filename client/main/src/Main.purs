module Main where

import Prelude hiding (append)

import Control.Bind ((=<<))

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

import LazyLoad

main = ready do
  on "click" (deleteArticleHandler) =<<  select "a[data-delete]"
  on "click" (menuLinkHandler) =<< select "#menuLink"
  on "click" (showViewHandler) =<< select "a[data-show]"

showViewHandler e el = do
  view :: String <- getAttr "data-show" el
  log $ "toggle " ++ show view
  void $ toggle =<< select ("[data-view="++ show view ++"]")

menuLinkHandler e el = do
  preventDefault e
  toggleClass "active" =<< select "#layout"
  toggleClass "active" =<< select "#menu"
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
