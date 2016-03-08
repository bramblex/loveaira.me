module Template.Category where

import Prelude
import Template.Base

import qualified Model.Category as M
import qualified Lib.Utils as Utils

list :: M.CategoryTree -> Template
list category_tree = do
  base
  title "分类"
  extend "content" do

    ifLogined $ \_ -> do
      t_p [] do
        t_a [ a_class := [pure_button, pure_button_primary]
            , a_href := "/category/create"] $ text "Create"
        text " "
        t_a [ a_class := [pure_button, pure_button_primary]
            , a_href', a_data_"show" := "operation"] $ text "Show/Hide Operation"
    t_ul [] do
      list' category_tree
    where list' :: M.CategoryTree -> Template
          list' (M.CategoryTree category children) = do
            t_li [] do
              t_a [a_href := "/article/category/" ++ show category.id]
                $ text category.name

              ifLogined $ \_ -> do
                t_span [a_style := "display: none;", a_data_"view" := "operation"] do
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
  title "创建新分类"
  extend "content" do

    t_form [a_class := [pure_form, pure_form_stacked], a_method := "POST"] do
      t_label [] $ text "parent: "
      category_select category_tree parent

      t_label [] $ text "name: "
      t_input [a_name := "name"]

      t_input [a_class := [pure_button, pure_button_primary], a_type := "submit"]

rename :: M.Category -> Template
rename category = do
  base
  title $ "重命名分类 - " ++ category.name
  extend "content" do

    t_form [a_class := [pure_form, pure_form_stacked], a_method := "POST"] do
      t_label [] $ text "Name: "
      text category.name
      t_label [] $ text "New Name: "
      t_input [a_name := "name"]
      t_input [a_class := [pure_button, pure_button_primary], a_type := "submit"]

move :: M.CategoryTree -> M.Category -> Template
move category_tree category = do
  base
  title $ "移动分类节点 - " ++ category.name
  extend "content" do

    t_form [a_class := [pure_form, pure_form_stacked], a_method := "POST"] do
      t_label [] $ text "Move to: "
      category_select category_tree category.parent_id
      t_input [a_class := [pure_button, pure_button_primary], a_type := "submit"]

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
  text "分类： "
  joinT (text " > ") $ flip map category_path \c -> do
    t_a [a_href := "/article/category/" ++ show c.id] $ text c.name
