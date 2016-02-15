module Init where

import Prelude
import Control.Monad.Eff.Console
import Model.Base
import qualified Model.User as UserModel
import qualified Model.Article as ArticleModel

main = do
  UserModel.init
  ArticleModel.init
