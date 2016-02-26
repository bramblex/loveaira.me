module Handler.Home where

import Handler.Base
import Control.Monad.Eff.Console
import Control.Monad.Eff.Class
import qualified Template.Home as T
import qualified Config as Config
import Model.Article (getHomePage)

import qualified Lib.Middleware as MW

import Lib.Utils as Utils
import Handler.User (requireLogin)

main :: forall eff. ModelApp eff
main = do
  get "/" index
  get "/favicon.ico" favicon
  post "/update" MW.githubWebhockHandler
  -- get "/update" $ requireLogin update

index = do
  homepage <- liftAff $ getHomePage
  render $ T.index homepage

favicon = do
  favicon <- liftEff $ Config.favicon_path
  download favicon

-- update = do
--   r <- liftEff $ Utils.runcmd "git pull && npm install"
--   send r

