module Template.Article where

import Prelude
import Data.Maybe
import Template.Base

import qualified Model.Article as M

list :: Array M.Article -> Template
list articles = do
  base
  title "Articles"
  extend "body" $ do
    t_a [a_href := "/article/create"] $ text "Create"

    t_table [] do
      t_tr [] do
        t_th [] $ text "Id"
        t_th [] $ text "Title"
        t_th [] $ text "Create At"
        t_th [] $ text "Update At"

      forT articles $ \article -> do
        t_tr [] do
          t_td [] $ text $ show article.id
          t_td [] $ t_a [a_href := "/article/show/" ++ show article.id] $ text article.title
          t_td [] $ text article.create_at
          t_td [] $ text article.update_at

create :: Template
create = do
  base
  title "Create"
  extend "body" $ do
    t_form [a_method := "POST"] do
      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "Title"
        t_tr [] do
          t_td [] $ t_input [a_name := "title"]
        t_tr [] do
          t_td [] $ t_label [] $ text "Content"
        t_tr [] do
          t_td [] $ t_textarea [a_name := "content"] $ text ""
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]

show_ :: M.Article -> Template
show_ article = do
  base
  title article.title
  extend "body" $ do

    t_p [] do
      text $ "Create At: " ++ article.create_at
      t_br []
      text $ "Update At: " ++ article.update_at

    text article.content

    t_hr []

    t_a [a_href := "/article/"] $ text "Go Back"
