module Template.Home where

import Prelude (show)
import Data.Maybe
import Template.Base
import Model.Article (Article())

index :: Article -> Template
index homepage = do
  base
  extend "header_subtitle" $ text ""
  extend "content" $ do
    t_div [a_class := ["article", "markdown-body"]] $ text homepage.content
    t_div [a_class := ["comments"]] $ comments "homepage"
