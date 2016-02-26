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
    t_div [a_class := [pure_g]] do

    ifLogined $ \_ ->
      t_div [a_class := [pure_u_1]] do
        t_p [] do
          t_a [ a_class := [pure_button, pure_button_primary]
              , a_href := "/article/create"] $ text "Create"

    -- t_div [a_class := [pure_u_1]] do
    article_list articles

category :: Array Category.RichArticle -> Category.Category -> Template
category articles category = do
  base
  title $ "Category " ++ category.name
  extend "body" $ do
    article_list articles

article_list :: Array Category.RichArticle -> Template
article_list articles = do

  t_div [a_class := pure_u_1] do
    t_table [a_class := [pure_table, pure_table_horizontal, pure_u_1]
            ,a_style := "display: table;"] do
      t_thead [] do
        t_tr [] do
          t_th [] $ text "Id"
          t_th [] $ text "Title"
          t_th [] $ text "Category"
          t_th [] $ text "Update At"
          t_th [] $ text "Create At"

      t_body [] do
        forT articles $ \article -> do
          t_tr [] do
            t_td [] $ text $ show article.id
            t_td [] do
              t_a [a_href := "/article/show/" ++ show article.id]
                $ text article.title
            t_td []  do
              t_a [a_href := "/article/category/" ++ show article.category.id]
                $ text article.category.name
            t_td [] $ text article.update_at
            t_td [] $ text article.create_at

show_ :: M.Article -> Array Category.Category -> Template
show_ article category_path = do
  base
  title $ "Article " ++ article.title
  extend "body" $ do
    t_div [a_class := [pure_g]] do


      t_div [a_class := [pure_u_1 ]] do
        t_div [a_class := ["article-category"]] do
          CT.breadcrumb_trail category_path
        ifLogined $ \_ -> do
          t_div [a_class := ["article-operate"]] do
            t_a [a_href := "/article/edit/" ++ show article.id] $ text "Edit"
            if article.id /= 0
              then do
                text " | "
                t_a [ a_data_"delete" := "/article/delete/" ++ show article.id
                    , a_data_"redirect" := "/article/"
                    , a_href := "#" ]
                  $ text "Delete"
              else text ""

      t_div [a_class := [pure_u_1, "markdown-body"]] do

        t_div [a_class := ["article"]] do

          t_div [a_class := ["article-title"]] do
            t_h1 [] $ text article.title

          t_div [a_class := ["article-content"]] do
            text article.content

      t_div [a_class := [pure_u_1]] do
        t_div [a_class := ["article-date"]] do
          t_small [] do
            text $ "Updated At: " ++ article.update_at
            text " | "
            text $ "Created At: " ++ article.create_at

      t_div [a_class := [pure_u_1, "article-comments"]] do
        comments $ "article_" ++ show article.id

create :: Category.CategoryTree -> Template
create category_tree = do
  base
  title "Create Article"

  extend "foot" $ do
    simplemdeEditor "simplemde" "article_create"

  extend "body" $ do
    t_form [a_class := [pure_form, pure_form_stacked], a_method := "POST"] do

      t_fieldset [] do

        t_label [] $ text "Title"
        t_input [a_class:=pure_input_1, a_name := "title"]

        t_label [] $ text "Category"
        CT.category_select category_tree 0

        t_label [] $ text "Content"
        t_textarea [a_name := "content", a_id := "simplemde"] $ text ""

        t_input [a_class := [pure_button, pure_button_primary], a_type := "submit"]

edit :: M.Article -> Category.CategoryTree -> Template
edit article category_tree = do
  base
  title $ "Edit Article " ++ article.title

  extend "foot" $ do
    simplemdeEditor "simplemde" $ "article_edit_" ++ show article.id

  extend "body" $ do

    t_form [a_class := [pure_form, pure_form_stacked], a_method := "POST"] do

      t_fieldset [] do

        t_label [] $ text "Title"
        t_input [a_class:=pure_input_1, a_name := "title"
                , a_value := article.title]

        t_label [] $ text "Category"
        CT.category_select category_tree article.category_id

        t_label [] $ text "Content"
        t_textarea [a_name := "content", a_id := "simplemde"]
          $ text article.raw_content

        t_input [a_class := [pure_button, pure_button_primary], a_type := "submit"]

simplemdeEditor :: String -> String -> Template
simplemdeEditor id cached_id = do
    css "//cdn.jsdelivr.net/simplemde/latest/simplemde.min.css"
    javascript "//cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"
    javascript "//cdn.jsdelivr.net/highlight.js/9.2.0/highlight.min.js"
    javascript_code
      $ "new SimpleMDE({autosave: {enabled: true, uniqueId: "++show cached_id++", delay: 1000}, renderingConfig:{codeSyntaxHighlighting:true}, spellChecker: false, element: document.getElementById("++show id++")});"
