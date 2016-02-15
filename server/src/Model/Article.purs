module Model.Article where

import Prelude
import Model.Base

table_name = "article"
schema = ["title" .=> "VARCHAR(255) NOT NULL", "content" .=> "TEXT NOT NULL", "category_id" .=> "INTEGER DEFAULT 0", "user_id" .=> "INTEGER DEFAULT 0 NOT NULL"]
init = createTable table_name schema

type Article = Record (title :: String, content :: String, category_id :: Int, user_id :: Int)

findArticle = find table_name
firstArticle = first table_name
findallArticle = findall table_name
insertArticle = insert table_name
updateArticle = update table_name
deleteArticle = delete table_name

listArticles = findallArticle ("id" .>= 0) (Asc "update_at")

findArticleById :: forall eff. Int -> ModelAff eff Article
findArticleById id = firstArticle ("id" .== id) (Asc "id")

createArticle :: forall eff. String -> String -> ModelAff eff Unit
createArticle title content = insertArticle ["title" .= title, "content" .= content]
