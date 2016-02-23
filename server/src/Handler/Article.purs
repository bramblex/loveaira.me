module Handler.Article where

import Handler.Base
import qualified Model.Article as M
import qualified Model.Category as Category
import qualified Template.Article as T
import Handler.User (requireLogin)
import Lib.CookieSession

import qualified Lib.Utils as Utils

main :: forall eff. ModelApp eff
main = do
  get "/" list
  get "/show/:id" show_
  get "/category/:id" category
  all "/create" $ requireLogin create
  all "/edit/:id" $ requireLogin edit
  get "/delete/:id" $ requireLogin delete_

list :: forall eff. ModelHandler eff
list = do
  articles <- liftAff $ M.listArticles
  categorys <- liftAff $ Category.listAllCategorys
  render $ T.list $ Category.withCategory articles categorys

show_ :: forall eff. ModelHandler eff
show_ = do
  idParam <- getRouteParam "id"
  case idParam of
    Just id -> do
      article <- liftAff $ M.findArticleById $ Utils.parseInt id
      category_path <- liftAff $ Category.getCategoryPath article.category_id
      render $ T.show_ article category_path
    _ -> redirect "/article"

create :: forall eff. ModelHandler eff
create = do
  method <- getMethod
  case method of
    Just GET -> do
      root_category_tree <- liftAff $ Category.getCategoryTree 0
      render $ T.create root_category_tree
    Just POST -> do
      Tuple (Just title:: Maybe String) (Just content:: Maybe String) <- Tuple <$> getBodyParam "title" <*> getBodyParam "content"
      (Just category_id) <- getBodyParam "category_id"
      liftAff $ M.createArticle title content (Utils.parseInt category_id)
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
          root_category_tree <- liftAff $ Category.getCategoryTree 0
          render $ T.edit article root_category_tree
        _ -> redirect "/article"
    Just POST -> do
      idParam <- getRouteParam "id"
      case idParam of
        Just id -> do
          Tuple (Just title:: Maybe String) (Just content:: Maybe String) <- Tuple <$> getBodyParam "title" <*> getBodyParam "content"
          (Just category_id) <- getBodyParam "category_id"
          liftAff $ M.updateArticleById (Utils.parseInt id) title content (Utils.parseInt category_id)
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

category :: forall eff. ModelHandler eff
category = do
  (Just category_id) <- getRouteParam "id"
  category_tree <- liftAff $ Category.getCategoryTree (Utils.parseInt category_id)
  let categorys = Category.getCategorysFromTree category_tree
  let ids = Category.filterId categorys
  articles <- liftAff $ M.findArticleByCategoryIds ids

  let category = Category.fromCategoryTree category_tree
  render $ T.category (Category.withCategory articles categorys) category
