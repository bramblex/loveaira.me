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

  t_p [] $ t_a [a_href := "/article/"] $ text "博客列表"

  t_p [] $ text "LoveAria 用 PureScript 重写了。现在已经实现大部分基本功能了。剩下的功能正在慢慢实现。心塞，本宝宝写个代码都那么忧伤。"
