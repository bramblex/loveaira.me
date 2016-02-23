module Template.Article where

import Prelude
import Data.Maybe
import Template.Base

import qualified Model.Article as M
import qualified Model.Category as Category

import qualified Template.Category as CT

list :: Array Category.RichArticle -> Template
list articles = do
  base
  title "Article"
  extend "body" $ do

    ifLogined $ \_ ->
      t_a [a_href := "/article/create"] $ text "Create"

    article_list articles

category :: Array Category.RichArticle -> Category.Category -> Template
category articles category = do
  base
  title $ "Category " ++ category.name
  extend "body" $ do
    article_list articles

article_list :: Array Category.RichArticle -> Template
article_list articles = do
  t_table [] do
    t_tr [] do
      t_th [] $ text "Id"
      t_th [] $ text "Title"
      t_th [] $ text "Category"
      t_th [] $ text "Create At"
      t_th [] $ text "Update At"

      forT articles $ \article -> do
        t_tr [] do
          t_td [] $ text $ show article.id
          t_td [] do
            t_a [a_href := "/article/show/" ++ show article.id]
              $ text article.title
          t_td []  do
            t_a [a_href := "/article/category/" ++ show article.category.id]
              $ text article.category.name
          t_td [] $ text article.create_at
          t_td [] $ text article.update_at

show_ :: M.Article -> Array Category.Category -> Template
show_ article category_path = do
  base
  title $ "Article " ++ article.title
  extend "body" $ do
    CT.breadcrumb_trail category_path
    t_hr []

    ifLogined $ \_ ->
      t_p [] do
        t_a [a_href := "/article/edit/" ++ show article.id] $ text "Edit"
        if article.id /= 0
          then do
            text " | "
            t_a [ a_data_"delete" := "/article/delete/" ++ show article.id
                , a_data_"redirect" := "/article/"
                , a_href := "#" ]
              $ text "Delete"
          else text ""

    t_p [] do
      text $ "Create At: " ++ article.create_at
      t_br []
      text $ "Update At: " ++ article.update_at

    text article.content

    t_hr []

    t_a [a_href := "/article/"] $ text "Go Back"

simplemdeEditor id = do
    t_link [a_rel := "stylesheet", a_href := "//cdn.jsdelivr.net/simplemde/latest/simplemde.min.css"]
    t_script' [a_src := "//cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"]
    t_script [] $
      text $ "new SimpleMDE({spellChecker: false, element: document.getElementById('"++id++"') });"

create :: Category.CategoryTree -> Template
create category_tree = do
  base
  title "Create Article"

  extend "foot" $ do
    simplemdeEditor "simplemde"

  extend "body" $ do
    t_form [a_method := "POST"] do
      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "Title"
        t_tr [] do
          t_td [] $ t_input [a_name := "title"]
        t_tr [] do
          t_td [] $ t_label [] $ text "Category"
        t_tr [] do
          t_td [] $ CT.category_select category_tree 0
        t_tr [] do
          t_td [] $ t_label [] $ text "Content"
        t_tr [] do
          t_td [] $ t_textarea [a_name := "content", a_id := "simplemde"] $ text ""
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]

edit :: M.Article -> Category.CategoryTree -> Template
edit article category_tree = do
  base
  title $ "Edit Article " ++ article.title

  extend "foot" $ do
    simplemdeEditor "simplemde"

  extend "body" $ do
    t_form [a_method := "POST"] do
      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "Title"
        t_tr [] do
          t_td [] $ t_input [a_name := "title", a_value := article.title]
        t_tr [] do
          t_td [] $ t_label [] $ text "Category"
        t_tr [] do
          t_td [] $ CT.category_select category_tree article.category_id
        t_tr [] do
          t_td [] $ t_label [] $ text "Content"
        t_tr [] do
          t_td [] $ t_textarea [a_name := "content", a_id := "simplemde"]
            $ text article.raw_content
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]

