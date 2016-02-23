module Template.Category where

import Prelude
import Template.Base

import qualified Model.Category as M
import qualified Lib.Utils as Utils

list :: M.CategoryTree -> Template
list category_tree = do
  base
  title "Category"
  extend "body" do

    ifLogined $ \_ -> do
      t_p [] do
        t_a [a_href := "/category/create"] $ text "Create"
    t_ul [] do
      list' category_tree
    where list' :: M.CategoryTree -> Template
          list' (M.CategoryTree category children) = do
            t_li [] do
              t_a [a_href := "/article/category/" ++ show category.id]
                $ text category.name

              ifLogined $ \_ -> do
                case category.id of
                  0 -> do
                    text " ( "
                    t_a [a_href := "/category/rename/"++show category.id]
                      $ text "Rename"
                    text " ) "
                  _ -> do
                    text " ( "
                    joinT (text " | ")
                      [ t_a [a_href := "/category/rename/"++show category.id]
                        $ text "Rename"
                      , t_a [a_href := "/category/move/" ++ show category.id]
                        $ text "Move"
                      , t_a [a_data_"delete":= "/category/delete/"++show category.id
                            , a_data_"redirect" := "/category/"
                            , a_href := "#"]
                        $ text "Delete"]
                    text " ) "

              forT children $ \c -> do
                t_ul [] do
                  list' c

create :: M.CategoryTree -> Int -> Template
create category_tree parent = do
  base
  title "Create Category"
  extend "body" do

    t_form [a_method := "POST"] do

      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "parent: "
          t_td [] $ category_select category_tree parent
        t_tr [] do
          t_td [] $ t_label [] $ text "name: "
          t_td [] $ t_input [a_name := "name"]
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]

rename :: M.Category -> Template
rename category = do
  base
  title $ "Rename Category " ++ category.name
  extend "body" do

    t_form [a_method := "POST"] do

      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "Name: "
          t_td [] $ text category.name
        t_tr [] do
          t_td [] $ t_label [] $ text "New Name: "
          t_td [] $ t_input [a_name := "name"]
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]

move :: M.CategoryTree -> M.Category -> Template
move category_tree category = do
  base
  title $ "Move Category " ++ category.name
  extend "body" do

    t_form [a_method := "POST"] do

      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "Move to: "
          t_td [] $ category_select category_tree category.parent_id
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]

category_select :: M.CategoryTree -> Int -> Template
category_select category_tree default_id = do
  t_select [a_name := "category_id"] do
    list' 0 category_tree
    where list' :: Int -> M.CategoryTree -> Template
          list' n (M.CategoryTree category children) = do
            t_option (if category.id == default_id then [a_value := show category.id, a_selected] else [a_value := show category.id]) do
              text (Utils.repeat n "━" ++ category.name)
            forT (children) $ \(c) -> do
              list' (n+1) c

breadcrumb_trail :: Array M.Category -> Template
breadcrumb_trail category_path = do
  t_p [] do
    joinT (text " > ") $ flip map category_path \c -> do
      t_a [a_href := "/article/category/" ++ show c.id] $ text c.name
      -- if c.id == 0
      --   then t_a [] $ text c.name
      --   else t_a [a_href := "/article/category/" ++ show c.id] $ text c.name
