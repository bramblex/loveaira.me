module Template.Base ( module Template.Base
                     , module Data.DOM.Tags
                     , module Data.DOM.Type
                     , module Data.DOM.Attributes
                     , module Prelude) where

import Prelude
import Data.Maybe
import Data.Foldable (foldl)
import Data.DOM.Tags
import Data.DOM.Type
import Data.DOM.Attributes

forT :: forall t. Array t -> (t -> Template) -> Template
forT ts f = foldl (\l a -> l >>= (\_ -> f a)) (text "") ts

base :: Template
base = do
  t_html [] do
    t_head [] do
      t_meta [a_name := "viewport", a_content := "width=device-width, initial-scale=1"]

      t_title [] $ do
        block "title_tab" $ Just do
          text "LoveAria.Me"

      t_link [a_rel := "stylesheet", a_src := "/static/css/pure-min.css"]
      t_script' [a_src := "/static/js/main.js"]

    t_body [] do
      t_header [] do
        block "logined_user" $ Just do
          t_a [a_style := "float: right", a_href := "/user/login"] $ text "Login"

        t_h1 [] $ do
          block "title_header" $ Just do
            text "LoveAria.Me"

        t_hr []

      t_div [] do

        block "body" $ Nothing

title :: String -> Template
title t = do
  extend "title_tab" $ text $ "LoveAria.me - " ++ t
  extend "title_header" $ text t

index :: Template
index = do
  base
  extend "body" $ do

    t_p [] $ t_a [a_href := "https://github.com/bramblex/loveaira.me"] $ text "GitHub 项目地址"

    t_p [] $ t_a [a_href := "/article/"] $ text "博客列表"

    t_p [] $ text "这是一个用纯 PureScript 实现的简易 Web 框架。还有好多蛋疼的问题正在解决中。现在就先凑活用了"


import Model.User (SimpleUser(), SessionUser(..), toSessionUser)

loginedUser :: forall t. SimpleUser t -> Template
loginedUser user = do
  extend "logined_user" do
    t_a [a_style := "float: right", a_href := "/user/status"] $ text $ user.username ++"("++user.role++")"
