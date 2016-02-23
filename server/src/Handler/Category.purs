
module Handler.Category where

import Handler.Base

import Control.Monad.Eff.Console (log)
import qualified Model.Category as M
import qualified Template.Category as T
import Handler.User (requireLogin)
import Data.Tuple
import qualified Lib.Utils as Utils


main :: forall eff. ModelApp eff
main = do
  use cleanWhilePost
  get "/" index
  all "/create/" $ requireLogin create
  all "/create/parent/:id" $ requireLogin create
  all "/rename/:id" $ requireLogin rename
  all "/move/:id" $ requireLogin move
  get "/delete/:id" $ requireLogin delete_

index = do
  root_category_tree <- liftAff $ M.getCategoryTree 0
  render $ T.list root_category_tree

create = do
  method <- getMethod
  case method of
    Just GET -> do
      result <- getRouteParam "id"
      case result of
        Just id -> do
          root_category_tree <- liftAff $ M.getCategoryTree 0
          render $ T.create root_category_tree $ Utils.parseInt id
        _ -> do
          root_category_tree <- liftAff $ M.getCategoryTree 0
          render $ T.create root_category_tree 0
    Just POST -> do
      result :: (Tuple (Maybe String) (Maybe String)) <- Tuple <$> getBodyParam "category_id" <*> getBodyParam "name"
      case result of
        Tuple (Just category_id) (Just name) -> do
          liftAff $ M.createCategoryNode name (Utils.parseInt category_id)
          redirect "/category/"
        _ -> send "Error"

    _ -> next

rename = do
  method <- getMethod
  case method of
    Just GET -> do
      result <- getRouteParam "id"
      case result of
        Just id -> do
          category <- liftAff $ M.findCategoryById (Utils.parseInt id)
          render $ T.rename category
        _ -> redirect "/category/"
    Just POST -> do
      Tuple (Just name) (Just id) <- Tuple <$> getBodyParam "name" <*> getRouteParam "id"
      liftAff $ M.renameCategoryNode (Utils.parseInt id) (name)
      redirect "/category/"
    _ -> next

move = do
  method <- getMethod
  case method of
    Just GET -> do
      result <- getRouteParam "id"
      case result of
        Just id -> do
          category <- liftAff $ M.findCategoryById (Utils.parseInt id)
          root_category_tree <- liftAff $ M.getCategoryTree 0
          render $ T.move root_category_tree category
        _ -> redirect "/category/"
    Just POST -> do
      Tuple (Just id) (Just parent_id) <- Tuple <$> getRouteParam "id" <*> getBodyParam "category_id"
      liftAff $ M.moveCategoryNodeTo (Utils.parseInt id) (Utils.parseInt parent_id)
      redirect "/category/"
    _ -> next

delete_ = do
  (Just id) <- getRouteParam "id"
  liftAff $ M.removeCategoryNode (Utils.parseInt id)
  redirect "/category/"
