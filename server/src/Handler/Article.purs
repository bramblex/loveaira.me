module Handler.Article where

import Handler.Base
import qualified Model.Article as M
import qualified Template.Article as T
import Handler.User (requireLogin)
import Lib.CookieSession

import qualified Lib.Utils as Utils

main :: forall eff. ModelApp eff
main = do
  get "/" list
  get "/show/:id" show_
  all "/create" $ requireLogin create

list :: forall eff. ModelHandler eff
list = do
  articles <- liftAff $ M.listArticles
  render $ T.list articles

create :: forall eff. ModelHandler eff
create = do
  method <- getMethod
  case method of
    Just GET -> render T.create
    Just POST -> do
      Tuple (Just title:: Maybe String) (Just content:: Maybe String) <- Tuple <$> getBodyParam "title" <*> getBodyParam "content"
      liftAff $ M.createArticle title content
      redirect "/article"
    _ -> next

show_ :: forall eff. ModelHandler eff
show_ = do
  idParam <- getRouteParam "id"
  case idParam of
    Just id -> do
      article <- liftAff $ M.findArticleById $ Utils.parseInt id
      render $ T.show_ article
    _ -> redirect "/article"
