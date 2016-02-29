module Template.Base ( module Template.Base
                     , module Template.Purecss
                     , module Data.DOM.Tags
                     , module Data.DOM.Type
                     , module Data.DOM.Attributes
                     , module Prelude) where
import Template.Purecss
import Prelude
import Data.Maybe
import Data.Tuple
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

-- some useful function
css :: String -> Template
css href = t_link [a_rel := "stylesheet", a_href := href]
javascript :: String -> Template
javascript src = t_script' [a_src := src]
javascript_code :: String -> Template
javascript_code code = t_script [] $ text code
a_href' = a_href := "javascript:void(0);"

link :: String -> String -> Template
link name url = t_a [a_href := url] $ text name

title :: String -> Template
title t = do
  extend "title" $ text $ "LoveAria.Me - " ++ t
  extend "header_title" $ text t

comments :: String -> Template
comments page_identifier = do
  t_div [a_class := [pure_g]] do
    t_div [a_class := [pure_u_1], a_id := "disqus_thread"] $ text ""
    javascript_code $ "var disqus_config = function () {this.page.identifier = "++ show page_identifier ++";}; (function() { var d = document, s = d.createElement('script'); s.src = '//lovearia.disqus.com/embed.js'; s.setAttribute('data-timestamp', +new Date()); (d.head || d.body).appendChild(s);})();"

base :: Template
base = do
  t_html [] do
    t_head [] do
      t_meta [ a_charset := "utf-8"]
      t_meta [ a_name := "viewport"
             , a_content := "width=device-width, initial-scale=1.0"]
      t_meta [ a_name := "description"
             , a_content := "Brambles' Blog."]

      t_title [] $ do
        block "title" $ Just do
          text "LoveAria.Me"

      t_link [a_rel := "shortcut icon", a_href := "/favicon.ico"]

      css "//cdn.jsdelivr.net/g/pure@0.6.0,github-markdown-css@2.2.1,highlight.js@9.2.0(styles/github.min.css)"
      css "/static/css/main.css"

      javascript "//cdn.jsdelivr.net/jquery/2.2.1/jquery.min.js"
      javascript "/static/js/main.js"

    t_body [] do
      t_div [a_id := "layout"] do

        t_a [a_href', a_id := "menuLink", a_class := ["menu-link"]] do
          t_span [] $ text ""

        t_div [a_id := "menu"] do
          t_div [a_class := [pure_menu]] do
            t_a [a_class := [pure_menu_heading]] $ text "LOVEARIA.ME"
            t_ul [a_class := [pure_menu_list]] do
              let menu_list =
                    [ Tuple "Home" "/"
                    , Tuple "Article" "/article"
                    , Tuple "Category" "/category"
                    , Tuple "Github" "https://github.com/bramblex" ]
              forT menu_list $ \(Tuple content url) ->
                t_li [a_class := [pure_menu_item]] do
                  t_a [a_class := [pure_menu_link], a_href := url] $ text content

              ifLoginedElse (
                \user -> do
                  t_li [a_class := [pure_menu_item, "menu-item-divided"]] do
                    t_a [a_class := [pure_menu_link]
                        ,a_href := "/user/status"] do
                      text user.username
                  let menu_list =
                        [Tuple "Clean Cache" "/cache/clean"
                        ,Tuple "Update System" "/update"]
                  forT menu_list $ \(Tuple name href) -> do
                    t_li [a_class := [pure_menu_item]] do
                      t_a [a_class := [pure_menu_link],a_href := href] do
                        text name
                ) (
                    t_li [a_class := [pure_menu_item, "menu-item-divided"]] do
                      t_a [a_class := [pure_menu_link]
                          ,a_href := "/user/login"] do
                        text "Login"
                )

        t_div [a_id := "main"] do

          t_div [a_class := ["header"]] do
            t_h1 [] $
              block "header_title" $ Just $ text "LoveAria.Me"
            t_h2 [] $
              block "header_subtitle" $ Nothing

          t_div [a_class := ["content"]] do
            block "content" Nothing

          t_div [a_class := ["footer"]] do
            text ""

      block "foot" Nothing

  -- t_html [] do
  --   t_head [] do
  --     t_meta [a_name := "viewport", a_content := "width=device-width, initial-scale=1"]

  --     t_title [] $ do
  --       block "title" $ Just do
  --         text "LoveAria.Me"

  --     t_link [a_rel := "shortcut icon", a_href := "/favicon.ico"]

  --     css "//cdn.jsdelivr.net/g/pure@0.6.0,github-markdown-css@2.2.1,highlight.js@9.2.0(styles/github.min.css)"
  --     css "/static/css/main.css"

  --     javascript "//cdn.jsdelivr.net/jquery/2.2.1/jquery.min.js"
  --     javascript "/static/js/main.js"

  --     block "head" $ Nothing

  --   t_body [] do
  --     t_div [a_class := [pure_g, "container"]] do

  --       -- header
  --       t_div [a_class := [pure_u_1, "header"]] do
  --         t_div [a_class := [pure_g]] do

  --           t_div [a_class := [pure_u_1, pure_menu, pure_menu_horizontal, "user-menu"]] do
  --             t_ul [a_class := [pure_menu_list], a_style := "float: right;"] do
  --                 ifLoginedElse (
  --                   \user -> do
  --                     let menu_list =
  --                           [Tuple user.username "/user/status"
  --                           ,Tuple "Clean Cache" "/cache/clean"
  --                           ,Tuple "Update System" "/update"]
  --                     forT menu_list $ \(Tuple name href) -> do
  --                       t_li [a_class := [pure_menu_item]] do
  --                         t_a [a_class := [pure_menu_link],a_href := href] do
  --                           text name
  --                   ) (
  --                       t_li [a_class := [pure_menu_item]] do
  --                         t_a [a_class := [pure_menu_link] ,a_href := "/user/login"] do
  --                           text "Login"
  --                   )

  --           t_div [a_class := [pure_u_1, "title"]] do
  --             t_h1 [] do
  --               text "LoveAria.Me"

  --           t_div [a_class := [pure_u_1, pure_menu, pure_menu_horizontal, "menu"]] do
  --             t_ul [a_class := [pure_menu_list]] do
  --               let menu_list =
  --                     [Tuple "Home" "/"
  --                     ,Tuple "Article" "/article"
  --                     ,Tuple "Category" "/category"
  --                     ,Tuple "Github" "https://github.com/bramblex"]
  --               forT menu_list $ \(Tuple name href) -> do
  --                 t_li [a_class := [pure_menu_item]] do
  --                   t_a [a_class := [pure_menu_link],a_href := href] do
  --                     text name

  --           separate

  --       -- content
  --       t_div [a_class := [pure_u_1, "content"]] do
  --         block "body" $ Nothing
          -- text "this is content"

        -- footer
        -- t_div [a_class := [pure_u_1, "footer"]] do

        -- foot
        -- block "foot" $ Nothing


-- separate :: Template
-- separate = t_div [a_class := [pure_u_1, "separate"]] $ t_hr []

