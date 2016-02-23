module Model.Category where

import Prelude
import Data.Maybe
import Model.Base

table_name = "category"
schema = [ "name" .=> "VARCHAR(255) UNIQUE NOT NULL"
         , "parent_id" .=> "INTEGER DEFAULT 0 NOT NULL DEFAULT 0" ]

init = do
  createTable table_name schema
  insertOrUpdateCategory [ "id" .= 0
                         , "name" .= "Root"
                         , "parent_id" .= 0 ]

type Category = Record (name :: String, parent_id :: Int)

findCategory = find table_name
firstCategory = first table_name
findallCategory = findall table_name
insertCategory = insert table_name
insertOrUpdateCategory = insertOrUpdate table_name
updateCategory = update table_name
deleteCategory = delete table_name

listAllCategorys :: forall eff. ModelAff eff (Array Category)
listAllCategorys = findallCategory ("id" .>= 0) (Desc "id")

findCategoryByName :: forall eff. String -> ModelAff eff Category
findCategoryByName name =
  firstCategory ("name" .== name) (Asc "id")

findCategoryById :: forall eff. Int -> ModelAff eff Category
findCategoryById id =
  firstCategory ("id" .== id) (Asc "id")

-- CategoryTree
import Data.Traversable (sequence)
import Data.Foldable (sequence_, any)
import qualified Model.Article as Article
import Lib.Utils

data CategoryTree = CategoryTree Category (Array CategoryTree)

getCategorysFromTree :: CategoryTree -> Array Category
getCategorysFromTree (CategoryTree category children) =
  [category] ++ getChildren children
    where getChildren :: Array CategoryTree -> Array Category
          getChildren = concatMap getCategorysFromTree

filterId :: Array Category -> Array Int
filterId = map (\c -> c.id)

isInCategoryTree :: Int -> CategoryTree -> Boolean
isInCategoryTree id (CategoryTree c children) =
  if c.id == id then true else isInChildren children
  where isInChildren :: Array CategoryTree -> Boolean
        isInChildren children = any (isInCategoryTree id) children

createCategoryNode :: forall eff. String -> Int -> ModelAff eff Category
createCategoryNode name parent_id = do
  insertCategory ["name" .= name, "parent_id" .= parent_id]
  findCategoryByName name

removeCategoryNode :: forall eff. Int -> ModelAff eff Unit
removeCategoryNode id = do
  case id of
    0 -> return unit
    _ -> do
      category <- findCategoryById id
      deleteCategory ("id" .== id)
      Article.updateArticle ["category_id" .= 0] ("category_id" .== id)
      children <- findallCategory ("parent_id" .== category.id) (Desc "id")
      sequence_ $ map (\c -> removeCategoryNode c.id) children

renameCategoryNode :: forall eff. Int -> String -> ModelAff eff Unit
renameCategoryNode id new_name =
  updateCategory ["name" .= new_name] ("id" .== id)

import Control.Monad.Eff.Exception
import Control.Monad.Eff.Class

moveCategoryNodeTo :: forall eff. Int -> Int -> ModelAff ( err::EXCEPTION | eff) Unit
moveCategoryNodeTo id parent_id = do
  case id of
    0 -> return unit
    _ -> do
      category_tree <- getCategoryTree id
      if isInCategoryTree parent_id category_tree
        then liftEff $ throw "Can not move node to there!"
        else updateCategory ["parent_id" .= parent_id] ("id" .== id)

getCategoryTree :: forall eff. Int -> ModelAff eff CategoryTree
getCategoryTree id = do
  category <- findCategoryById id
  children <- findallCategory ("parent_id" .== category.id .&& "id" .!= 0) (Desc "id")
  children_tree <- sequence $ map (\c -> getCategoryTree c.id) $ children
  return $ CategoryTree category children_tree

fromCategoryTree :: forall eff. CategoryTree -> Category
fromCategoryTree (CategoryTree c _) = c

-- Category Path

getCategoryPath :: forall eff. Int -> ModelAff eff (Array Category)
getCategoryPath id = do
  category <- findCategoryById id
  case id of
    0 -> return [category]
    _ -> do
      category <- findCategoryById id
      parent_path <- getCategoryPath category.parent_id
      return $ parent_path ++ [category]

import qualified Data.Foldable as F

type RichArticle = Record (title :: String, content :: String, raw_content :: String, category_id :: Int, category :: Category, user_id :: Int)

withCategory :: forall eff. Array Article.Article -> Array Category -> Array RichArticle
withCategory as cs = map f as
  where f :: Article.Article -> RichArticle
        f a = let result = F.find (\c->c.id == a.category_id) cs
              in case result of
                      Just c -> merge a {category: c}
