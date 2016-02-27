module Model.Article where

import Prelude
import Model.Base


import qualified Lib.Utils as Utils

table_name = "article"
schema = [ "title" .=> "VARCHAR(255) NOT NULL"
         , "content" .=> "TEXT NOT NULL"
         , "raw_content" .=> "TEXT NOT NULL"
         , "category_id" .=> "INTEGER DEFAULT 0"
         , "user_id" .=> "INTEGER DEFAULT 0 NOT NULL" ]

init = do
  createTable table_name schema
  insertOrUpdateArticle [ "id" .= 0
                         , "title" .= "Home Page"
                         , "category_id" .= 0
                         , "raw_content" .= "#This is Home Page"
                         , "content" .= Markdown "#This is Home Page"]

type Article = Record (title :: String, content :: String, raw_content :: String, category_id :: Int, user_id :: Int)

findArticle = find table_name
firstArticle = first table_name
findallArticle = findall table_name
insertArticle = insert table_name
insertOrUpdateArticle = insertOrUpdate table_name
updateArticle = update table_name
deleteArticle = delete table_name

listArticles = findallArticle ("id" .>= 0) (Desc "create_at")

findArticleById :: forall eff. Int -> ModelAff eff Article
findArticleById id = firstArticle ("id" .== id) (Desc "create_at")

findArticleByCategoryIds :: forall eff. Array Int -> ModelAff eff (Array Article)
findArticleByCategoryIds ids = findallArticle ("category_id" .<- ids) (Desc "create_at")

getHomePage = findArticleById 0

import qualified Lib.Utils as Utils

newtype Markdown = Markdown String
instance isValueMarkdown :: IsValue Markdown where
  toValue (Markdown str) = toValue <<< Utils.mdToHtml $ str

createArticle :: forall eff. String -> String -> Int -> ModelAff eff Unit
createArticle title content category_id =
  insertArticle [ "title" .= title
                , "category_id" .= category_id
                , "raw_content" .= content
                , "content" .= Markdown content ]

updateArticleById :: forall eff. Int -> String -> String -> Int -> ModelAff eff Unit
updateArticleById id title content category_id =
  updateArticle [ "title" .= title
                , "category_id" .= category_id
                , "raw_content" .= content
                , "content" .= Markdown content] ("id" .== id)

deleteArticleById :: forall eff. Int -> ModelAff eff Unit
deleteArticleById id = deleteArticle ("id" .== id)
