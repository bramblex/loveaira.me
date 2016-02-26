module Template.User where

import Prelude (show)
import Data.Maybe
import Template.Base

import qualified Lib.CookieSession as M

login :: Maybe String -> Template
login mes = do
  base
  title "Login"
  extend "content" $ do

    case mes of
      Just m -> t_p [] $ text m
      _ -> text ""

    t_form [a_class := [pure_form, pure_form_stacked], a_method := "POST"] do
      t_label [] $ text "username: "
      t_input [a_name := "username"]
      t_label [] $ text "password: "
      t_input [a_name := "password", a_type := "password"]
      t_input [a_class := [pure_button, pure_button_primary], a_type := "submit"]

status :: forall t. M.SimpleUser t -> Template
status user = do
  base
  title "Status"
  extend "content" $ do

    t_table [] do

      t_tr [] do
        t_td [] $ text "User ID:"
        t_td [] $ text (show user.id)

      t_tr [] do
        t_td [] $ text "User Name:"
        t_td [] $ text user.username

      t_tr [] do
        t_td [] $ text "Role:"
        t_td [] $ text user.role

      t_tr [] do
        t_td [a_colspan := "2"] do
          t_a [a_href := "/user/changePassword"] $ text "Change Password"

      t_tr [] do
        t_td [a_colspan := "2"] do
          t_a [a_href := "/user/logout"] $ text "Logout"

changePassword :: forall t. M.SimpleUser t -> Maybe String -> Template
changePassword user mes = do
  base
  title "Change Password"
  extend "content" $ do

    case mes of
      Just m -> t_p [] $ text m
      _ -> text ""

    t_form [a_method := "POST"] do

      t_table [] do
        t_tr [] do
          t_td [] $ t_label [] $ text "username: "
          t_td [] $ text user.username
        t_tr [] do
          t_td [] $ t_label [] $ text "password: "
          t_td [] $ t_input [a_name := "password", a_type := "password"]
        t_tr [] do
          t_td [] $ t_label [] $ text "new password: "
          t_td [] $ t_input [a_name := "newpassword", a_type := "password"]
        t_tr [] do
          t_td [] $ t_label [] $ text "repeated: "
          t_td [] $ t_input [a_name := "repeated", a_type := "password"]
        t_tr [] do
          t_td [] $ t_input [a_type := "submit"]
