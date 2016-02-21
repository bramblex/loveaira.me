module Model.Article where

import Prelude
import Model.Base

table_name = "article"
schema = [ "title" .=> "VARCHAR(255) NOT NULL"
         , "content" .=> "TEXT NOT NULL"
         , "raw_content" .=> "TEXT NOT NULL"
         , "category_id" .=> "INTEGER DEFAULT 0"
         , "user_id" .=> "INTEGER DEFAULT 0 NOT NULL" ]
init = createTable table_name schema

type Article = Record (title :: String, content :: String, raw_content :: String, category_id :: Int, user_id :: Int)

findArticle = find table_name
firstArticle = first table_name
findallArticle = findall table_name
insertArticle = insert table_name
updateArticle = update table_name
deleteArticle = delete table_name

listArticles = findallArticle ("id" .>= 0) (Desc "update_at")

findArticleById :: forall eff. Int -> ModelAff eff Article
findArticleById id = firstArticle ("id" .== id) (Asc "id")

import qualified Lib.Utils as Utils

newtype Markdown = Markdown String
instance isValueMarkdown :: IsValue Markdown where
  toValue (Markdown str) = toValue <<< Utils.mdToHtml $ str

createArticle :: forall eff. String -> String -> ModelAff eff Unit
createArticle title content =
  insertArticle [ "title" .= title
                , "raw_content" .= content
                , "content" .= Markdown content ]

updateArticleById :: forall eff. Int -> String -> String -> ModelAff eff Unit
updateArticleById id title content =
  updateArticle [ "title" .= title
                , "raw_content" .= content
                , "content" .= Markdown content] ("id" .== id)

deleteArticleById :: forall eff. Int -> ModelAff eff Unit
deleteArticleById id = deleteArticle ("id" .== id)
