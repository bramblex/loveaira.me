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
  all "/edit/:id" $ requireLogin edit
  get "/delete/:id" $ requireLogin delete_

list :: forall eff. ModelHandler eff
list = do
  articles <- liftAff $ M.listArticles
  render $ T.list articles

show_ :: forall eff. ModelHandler eff
show_ = do
  idParam <- getRouteParam "id"
  case idParam of
    Just id -> do
      article <- liftAff $ M.findArticleById $ Utils.parseInt id
      render $ T.show_ article
    _ -> redirect "/article"

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

edit :: forall eff. ModelHandler eff
edit = do
  method <- getMethod
  case method of
    Just GET -> do
      idParam <- getRouteParam "id"
      case idParam of
        Just id -> do
          article <- liftAff $ M.findArticleById $ Utils.parseInt id
          render <<< T.edit $ article
        _ -> redirect "/article"
    Just POST -> do
      idParam <- getRouteParam "id"
      case idParam of
        Just id -> do
          Tuple (Just title:: Maybe String) (Just content:: Maybe String) <- Tuple <$> getBodyParam "title" <*> getBodyParam "content"
          liftAff $ M.updateArticleById (Utils.parseInt id) title content
          redirect $ "/article/show/" ++ id
        _ -> do
          redirect $ "/article"
    _ -> next


delete_ :: forall eff. ModelHandler eff
delete_ = do
  idParam <- getRouteParam "id"
  case idParam of
    Just id -> do
      liftAff $ M.deleteArticleById (Utils.parseInt id)
      redirect "/article"
    _ -> redirect "/article"
