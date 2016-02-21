module Data.DOM.Tags where

import Prelude
import Data.Maybe
import Control.Monad.Free

import Data.DOM.Type


type Template = Content Unit

element :: String -> Array Attribute -> Maybe (Template) -> Element
element name attr cont = Element { name: name
                                 , attr: attr
                                 , cont: cont }

text :: String -> Template
text str = liftF $ TextContent str unit

elem :: Element -> Template
elem e = liftF $ ElementContent e unit

block :: String -> Maybe (Template) -> Template
block name cont = liftF $ BlockContent (Block {name:name, cont:cont}) unit

extend :: String -> Template -> Template
extend name cont = liftF $ ExtendContent (Block {name:name, cont:Just cont}) unit

import Lib.CookieSession (Session(..), SimpleUser())

session :: Content Session
session = liftF $ GetSession id

sessionIsLogined :: Content Boolean
sessionIsLogined = do
  (Session s) <- session
  return s.is_logined

sessionGetUser :: Content (Maybe (SimpleUser ()))
sessionGetUser = do
  (Session s) <- session
  return s.user

ifLogined :: (SimpleUser () -> Template) -> Template
ifLogined k = do
  (Session s) <- session
  case s.is_logined of
    false -> text ""
    true -> (\(Just u) -> k u) s.user

ifLoginedElse :: (SimpleUser () -> Template) -> Template -> Template
ifLoginedElse k d = do
  (Session s) <- session
  case s.is_logined of
    false -> d
    true -> (\(Just u) -> k u) s.user

-- Normal Tags --

t_a :: Array Attribute -> Template -> Template
t_a attr cont = elem $ element "a" attr (Just cont)

t_abbr :: Array Attribute -> Template -> Template
t_abbr attr cont = elem $ element "abbr" attr (Just cont)

t_acronym :: Array Attribute -> Template -> Template
t_acronym attr cont = elem $ element "acronym" attr (Just cont)

t_address :: Array Attribute -> Template -> Template
t_address attr cont = elem $ element "address" attr (Just cont)

t_applet :: Array Attribute -> Template -> Template
t_applet attr cont = elem $ element "applet" attr (Just cont)

t_article :: Array Attribute -> Template -> Template
t_article attr cont = elem $ element "article" attr (Just cont)

t_aside :: Array Attribute -> Template -> Template
t_aside attr cont = elem $ element "aside" attr (Just cont)

t_audio :: Array Attribute -> Template -> Template
t_audio attr cont = elem $ element "audio" attr (Just cont)

t_b :: Array Attribute -> Template -> Template
t_b attr cont = elem $ element "b" attr (Just cont)

t_basefont :: Array Attribute -> Template -> Template
t_basefont attr cont = elem $ element "basefont" attr (Just cont)

t_bdi :: Array Attribute -> Template -> Template
t_bdi attr cont = elem $ element "bdi" attr (Just cont)

t_bdo :: Array Attribute -> Template -> Template
t_bdo attr cont = elem $ element "bdo" attr (Just cont)

t_big :: Array Attribute -> Template -> Template
t_big attr cont = elem $ element "big" attr (Just cont)

t_blockquote :: Array Attribute -> Template -> Template
t_blockquote attr cont = elem $ element "blockquote" attr (Just cont)

t_body :: Array Attribute -> Template -> Template
t_body attr cont = elem $ element "body" attr (Just cont)

t_button :: Array Attribute -> Template -> Template
t_button attr cont = elem $ element "button" attr (Just cont)

t_canvas :: Array Attribute -> Template -> Template
t_canvas attr cont = elem $ element "canvas" attr (Just cont)

t_caption :: Array Attribute -> Template -> Template
t_caption attr cont = elem $ element "caption" attr (Just cont)

t_center :: Array Attribute -> Template -> Template
t_center attr cont = elem $ element "center" attr (Just cont)

t_cite :: Array Attribute -> Template -> Template
t_cite attr cont = elem $ element "cite" attr (Just cont)

t_code :: Array Attribute -> Template -> Template
t_code attr cont = elem $ element "code" attr (Just cont)

t_colgroup :: Array Attribute -> Template -> Template
t_colgroup attr cont = elem $ element "colgroup" attr (Just cont)

t_command :: Array Attribute -> Template -> Template
t_command attr cont = elem $ element "command" attr (Just cont)

t_datalist :: Array Attribute -> Template -> Template
t_datalist attr cont = elem $ element "datalist" attr (Just cont)

t_dd :: Array Attribute -> Template -> Template
t_dd attr cont = elem $ element "dd" attr (Just cont)

t_del :: Array Attribute -> Template -> Template
t_del attr cont = elem $ element "del" attr (Just cont)

t_details :: Array Attribute -> Template -> Template
t_details attr cont = elem $ element "details" attr (Just cont)

t_dir :: Array Attribute -> Template -> Template
t_dir attr cont = elem $ element "dir" attr (Just cont)

t_div :: Array Attribute -> Template -> Template
t_div attr cont = elem $ element "div" attr (Just cont)

t_dfn :: Array Attribute -> Template -> Template
t_dfn attr cont = elem $ element "dfn" attr (Just cont)

t_dialog :: Array Attribute -> Template -> Template
t_dialog attr cont = elem $ element "dialog" attr (Just cont)

t_dl :: Array Attribute -> Template -> Template
t_dl attr cont = elem $ element "dl" attr (Just cont)

t_dt :: Array Attribute -> Template -> Template
t_dt attr cont = elem $ element "dt" attr (Just cont)

t_em :: Array Attribute -> Template -> Template
t_em attr cont = elem $ element "em" attr (Just cont)

t_fieldset :: Array Attribute -> Template -> Template
t_fieldset attr cont = elem $ element "fieldset" attr (Just cont)

t_figcaption :: Array Attribute -> Template -> Template
t_figcaption attr cont = elem $ element "figcaption" attr (Just cont)

t_figure :: Array Attribute -> Template -> Template
t_figure attr cont = elem $ element "figure" attr (Just cont)

t_font :: Array Attribute -> Template -> Template
t_font attr cont = elem $ element "font" attr (Just cont)

t_footer :: Array Attribute -> Template -> Template
t_footer attr cont = elem $ element "footer" attr (Just cont)

t_form :: Array Attribute -> Template -> Template
t_form attr cont = elem $ element "form" attr (Just cont)

t_frame :: Array Attribute -> Template -> Template
t_frame attr cont = elem $ element "frame" attr (Just cont)

t_frameset :: Array Attribute -> Template -> Template
t_frameset attr cont = elem $ element "frameset" attr (Just cont)

t_h1 :: Array Attribute -> Template -> Template
t_h1 attr cont = elem $ element "h1" attr (Just cont)

t_h2 :: Array Attribute -> Template -> Template
t_h2 attr cont = elem $ element "h2" attr (Just cont)

t_h3 :: Array Attribute -> Template -> Template
t_h3 attr cont = elem $ element "h3" attr (Just cont)

t_h4 :: Array Attribute -> Template -> Template
t_h4 attr cont = elem $ element "h4" attr (Just cont)

t_h5 :: Array Attribute -> Template -> Template
t_h5 attr cont = elem $ element "h5" attr (Just cont)

t_h6 :: Array Attribute -> Template -> Template
t_h6 attr cont = elem $ element "h6" attr (Just cont)

t_head :: Array Attribute -> Template -> Template
t_head attr cont = elem $ element "head" attr (Just cont)

t_header :: Array Attribute -> Template -> Template
t_header attr cont = elem $ element "header" attr (Just cont)

t_html :: Array Attribute -> Template -> Template
t_html attr cont = elem $ element "html" attr (Just cont)

t_i :: Array Attribute -> Template -> Template
t_i attr cont = elem $ element "i" attr (Just cont)

t_iframe :: Array Attribute -> Template -> Template
t_iframe attr cont = elem $ element "iframe" attr (Just cont)


t_ins :: Array Attribute -> Template -> Template
t_ins attr cont = elem $ element "ins" attr (Just cont)

t_isindex :: Array Attribute -> Template -> Template
t_isindex attr cont = elem $ element "isindex" attr (Just cont)

t_kbd :: Array Attribute -> Template -> Template
t_kbd attr cont = elem $ element "kbd" attr (Just cont)

t_label :: Array Attribute -> Template -> Template
t_label attr cont = elem $ element "label" attr (Just cont)

t_legend :: Array Attribute -> Template -> Template
t_legend attr cont = elem $ element "legend" attr (Just cont)

t_li :: Array Attribute -> Template -> Template
t_li attr cont = elem $ element "li" attr (Just cont)

t_map :: Array Attribute -> Template -> Template
t_map attr cont = elem $ element "map" attr (Just cont)

t_mark :: Array Attribute -> Template -> Template
t_mark attr cont = elem $ element "mark" attr (Just cont)

t_menu :: Array Attribute -> Template -> Template
t_menu attr cont = elem $ element "menu" attr (Just cont)

t_menuitem :: Array Attribute -> Template -> Template
t_menuitem attr cont = elem $ element "menuitem" attr (Just cont)

t_meter :: Array Attribute -> Template -> Template
t_meter attr cont = elem $ element "meter" attr (Just cont)

t_nav :: Array Attribute -> Template -> Template
t_nav attr cont = elem $ element "nav" attr (Just cont)

t_noframes :: Array Attribute -> Template -> Template
t_noframes attr cont = elem $ element "noframes" attr (Just cont)

t_noscript :: Array Attribute -> Template -> Template
t_noscript attr cont = elem $ element "noscript" attr (Just cont)

t_object :: Array Attribute -> Template -> Template
t_object attr cont = elem $ element "object" attr (Just cont)

t_ol :: Array Attribute -> Template -> Template
t_ol attr cont = elem $ element "ol" attr (Just cont)

t_optgroup :: Array Attribute -> Template -> Template
t_optgroup attr cont = elem $ element "optgroup" attr (Just cont)

t_option :: Array Attribute -> Template -> Template
t_option attr cont = elem $ element "option" attr (Just cont)

t_output :: Array Attribute -> Template -> Template
t_output attr cont = elem $ element "output" attr (Just cont)

t_p :: Array Attribute -> Template -> Template
t_p attr cont = elem $ element "p" attr (Just cont)

t_pre :: Array Attribute -> Template -> Template
t_pre attr cont = elem $ element "pre" attr (Just cont)

t_progress :: Array Attribute -> Template -> Template
t_progress attr cont = elem $ element "progress" attr (Just cont)

t_q :: Array Attribute -> Template -> Template
t_q attr cont = elem $ element "q" attr (Just cont)

t_rp :: Array Attribute -> Template -> Template
t_rp attr cont = elem $ element "rp" attr (Just cont)

t_rt :: Array Attribute -> Template -> Template
t_rt attr cont = elem $ element "rt" attr (Just cont)

t_ruby :: Array Attribute -> Template -> Template
t_ruby attr cont = elem $ element "ruby" attr (Just cont)

t_s :: Array Attribute -> Template -> Template
t_s attr cont = elem $ element "s" attr (Just cont)

t_samp :: Array Attribute -> Template -> Template
t_samp attr cont = elem $ element "samp" attr (Just cont)

t_section :: Array Attribute -> Template -> Template
t_section attr cont = elem $ element "section" attr (Just cont)

t_select :: Array Attribute -> Template -> Template
t_select attr cont = elem $ element "select" attr (Just cont)

t_small :: Array Attribute -> Template -> Template
t_small attr cont = elem $ element "small" attr (Just cont)

t_span :: Array Attribute -> Template -> Template
t_span attr cont = elem $ element "span" attr (Just cont)

t_strike :: Array Attribute -> Template -> Template
t_strike attr cont = elem $ element "strike" attr (Just cont)

t_strong :: Array Attribute -> Template -> Template
t_strong attr cont = elem $ element "strong" attr (Just cont)

t_style :: Array Attribute -> Template -> Template
t_style attr cont = elem $ element "style" attr (Just cont)

t_sub :: Array Attribute -> Template -> Template
t_sub attr cont = elem $ element "sub" attr (Just cont)

t_summary :: Array Attribute -> Template -> Template
t_summary attr cont = elem $ element "summary" attr (Just cont)

t_sup :: Array Attribute -> Template -> Template
t_sup attr cont = elem $ element "sup" attr (Just cont)

t_table :: Array Attribute -> Template -> Template
t_table attr cont = elem $ element "table" attr (Just cont)

t_tbody :: Array Attribute -> Template -> Template
t_tbody attr cont = elem $ element "tbody" attr (Just cont)

t_td :: Array Attribute -> Template -> Template
t_td attr cont = elem $ element "td" attr (Just cont)

t_textarea :: Array Attribute -> Template -> Template
t_textarea attr cont = elem $ element "textarea" attr (Just cont)

t_tfoot :: Array Attribute -> Template -> Template
t_tfoot attr cont = elem $ element "tfoot" attr (Just cont)

t_th :: Array Attribute -> Template -> Template
t_th attr cont = elem $ element "th" attr (Just cont)

t_thead :: Array Attribute -> Template -> Template
t_thead attr cont = elem $ element "thead" attr (Just cont)

t_time :: Array Attribute -> Template -> Template
t_time attr cont = elem $ element "time" attr (Just cont)

t_title :: Array Attribute -> Template -> Template
t_title attr cont = elem $ element "title" attr (Just cont)

t_tr :: Array Attribute -> Template -> Template
t_tr attr cont = elem $ element "tr" attr (Just cont)

t_tt :: Array Attribute -> Template -> Template
t_tt attr cont = elem $ element "tt" attr (Just cont)

t_u :: Array Attribute -> Template -> Template
t_u attr cont = elem $ element "u" attr (Just cont)

t_ul :: Array Attribute -> Template -> Template
t_ul attr cont = elem $ element "ul" attr (Just cont)

t_var :: Array Attribute -> Template -> Template
t_var attr cont = elem $ element "var" attr (Just cont)

t_video :: Array Attribute -> Template -> Template
t_video attr cont = elem $ element "video" attr (Just cont)

t_xmp :: Array Attribute -> Template -> Template
t_xmp attr cont = elem $ element "xmp" attr (Just cont)

-- Self Closing Tags --

t_area :: Array Attribute -> Template
t_area attr = elem $ element "area" attr Nothing

t_base :: Array Attribute -> Template
t_base attr = elem $ element "base" attr Nothing

t_br :: Array Attribute -> Template
t_br attr = elem $ element "br" attr Nothing

t_col :: Array Attribute -> Template
t_col attr = elem $ element "col" attr Nothing

t_embed :: Array Attribute -> Template
t_embed attr = elem $ element "embed" attr Nothing

t_hr :: Array Attribute -> Template
t_hr attr = elem $ element "hr" attr Nothing

t_img :: Array Attribute -> Template
t_img attr = elem $ element "img" attr Nothing

t_input :: Array Attribute -> Template
t_input attr = elem $ element "input" attr Nothing

t_keygen :: Array Attribute -> Template
t_keygen attr = elem $ element "keygen" attr Nothing

t_link :: Array Attribute -> Template
t_link attr = elem $ element "link" attr Nothing

t_meta :: Array Attribute -> Template
t_meta attr = elem $ element "meta" attr Nothing

t_param :: Array Attribute -> Template
t_param attr = elem $ element "param" attr Nothing

t_source :: Array Attribute -> Template
t_source attr = elem $ element "source" attr Nothing

t_track :: Array Attribute -> Template
t_track attr = elem $ element "track" attr Nothing

t_wbr :: Array Attribute -> Template
t_wbr attr = elem $ element "wbr" attr Nothing

-- Script Tag

t_script :: Array Attribute -> Template -> Template
t_script attr cont = elem $ element "script" attr (Just cont)

t_script' :: Array Attribute -> Template
t_script' attr = elem $ element "script" attr (Just $ text "")
