module Init where

import Prelude
import Control.Monad.Eff.Console
import Control.Monad.Eff.Class
import Model.Base
import qualified Model.User as UserModel
import qualified Model.Article as ArticleModel
import qualified Model.Category as CategoryModel

import qualified Lib.Utils as Utils

main :: forall eff. ModelAff eff Unit
main = do
  UserModel.init
  ArticleModel.init
  CategoryModel.init

createUser :: forall eff. String -> ModelAff (console:: CONSOLE |eff) Unit
createUser user = do
  password <- liftEff $ Utils.randString 8
  UserModel.insertOrUpdateUser [ "id" .= 0
                               , "username" .= user
                               , "role" .= "admin"
                               , "password" .= UserModel.Password password ]
  liftEff $ log $ "Create User: " ++ user
  liftEff $ log $ "Password: " ++ password
