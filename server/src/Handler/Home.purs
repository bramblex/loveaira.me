module Handler.Home where

import Handler.Base
import Control.Monad.Eff.Console
import qualified Template.Home as T
import qualified Config as Config
import Model.Article (getHomePage)

main :: forall eff. ModelApp eff
main = do
  get "/" index
  get "/favicon.ico" favicon

index = do
  homepage <- liftAff $ getHomePage
  render $ T.index homepage

favicon = do
  favicon <- liftEff $ Config.favicon_path
  download favicon
