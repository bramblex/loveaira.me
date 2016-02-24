module Template.Base ( module Template.Base
                     , module Data.DOM.Tags
                     , module Data.DOM.Type
                     , module Data.DOM.Attributes
                     , module Prelude) where

import Prelude
import Data.Maybe
import Data.Foldable hiding (elem)
import Data.DOM.Tags
import Data.DOM.Type
import Data.DOM.Attributes

forT :: forall t. Array t -> (t -> Template) -> Template
forT ts f = foldl (\l a -> l >>= (\_ -> f a)) (text "") ts

joinT :: Template -> Array Template -> Template
joinT s ts = fromMaybe (text "") (foldl mf Nothing ts)
  where f a b = a >>= (\_ -> s >>= (\_ -> b))
        mf m y = Just (case m of
                          Nothing -> y
                          Just x -> f x y)

base :: Template
base = do
  t_html [] do
    t_head [] do
      t_meta [a_name := "viewport", a_content := "width=device-width, initial-scale=1"]

      t_title [] $ do
        block "title_tab" $ Just do
          text "LoveAria.Me"

      -- t_link [a_rel := "stylesheet", a_href := "/static/css/pure-min.css"]
      t_link [a_rel := "stylesheet", a_href := "/static/css/main.css"]
      t_link [a_rel := "shortcut icon", a_href := "/favicon.ico"]
      t_script' [a_src := "/static/components/jquery-2.2.1.min.js"]
      t_script' [a_src := "/static/js/main.js"]

      block "head" $ Nothing

    t_body [] do
      t_header [] do

        ifLoginedElse (
          \user -> t_a [a_style := "float: right", a_href := "/user/status"] $ text $ user.username ++"("++user.role++")"
          ) (
          t_a [a_style := "float: right", a_href := "/user/login"] $ text "Login"
          )

        t_h1 [] $ do
          block "title_header" $ Just do
            text "LoveAria.Me"

        t_p [] $ do
          joinT (text " | ")
            [ t_a [a_href := "/"] $ text "Home"
            , t_a [a_href := "/article"] $ text "Article"
            , t_a [a_href := "/category"] $ text "Category"
            , t_a [a_href := "https://github.com/bramblex"] $ text "Github" ]

        t_hr []

      t_div [] do

        block "body" $ Nothing

      block "foot" $ Nothing

title :: String -> Template
title t = do
  extend "title_tab" $ text $ "LoveAria.me - " ++ t
  extend "title_header" $ text t

comments :: String -> Template
comments page_identifier = do
  text $ "<div id=\"disqus_thread\"></div> <script> var disqus_config = function () {this.page.identifier = "++ show page_identifier ++";}; (function() { var d = document, s = d.createElement('script'); s.src = '//lovearia.disqus.com/embed.js'; s.setAttribute('data-timestamp', +new Date()); (d.head || d.body).appendChild(s);})(); </script> <noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\" rel=\"nofollow\">comments powered by Disqus.</a></noscript>"

-- import Lib.CookieSession (SimpleUser(), SessionUser(..), toSessionUser)

-- loginedUser :: forall t. SimpleUser t -> Template
-- loginedUser user = do
--   extend "logined_user" do
    -- t_a [a_style := "float: right", a_href := "/user/status"] $ text $ user.username ++"("++user.role++")"
