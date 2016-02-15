module Template.Base ( module Template.Base
                     , module Data.DOM.Tags
                     , module Data.DOM.Attributes
                     , module Prelude) where

import Prelude
import Data.Maybe
import Data.Foldable (foldl)
import Data.DOM.Tags
import Data.DOM.Attributes

forT :: forall t. Array t -> (t -> Template) -> Template
forT ts f = foldl (\l a -> l >>= (\_ -> f a)) (text "") ts

base :: Template -> Template
base body = do
  t_html [] do
    t_head [] do
      t_meta [a_name := "viewport", a_content := "width=device-width, initial-scale=1"]
      t_title [] $ text "LoveAria.Me"
      t_link [a_rel := "stylesheet", a_src := "/static/css/pure-min.css"]
      t_script' [a_src := "/static/js/main.js"]

    t_body [] do
      t_header [] do
        t_a [a_style := "float: right", a_href := "/user/status"] $ text "Login"
      t_div [] do
        body

index :: Template
index = base $ do
  t_h1 [] $ text "LoveAria"
  t_hr []

  t_p [] $ t_a [a_href := "https://github.com/bramblex/loveaira.me"] $ text "GitHub 项目地址"

  t_p [] $ t_a [a_href := "/article/"] $ text "博客列表"

  t_p [] $ text "这是一个用纯 PureScript 实现的简易 Web 框架。还有好多蛋疼的问题正在解决中。现在就先凑活用了"
