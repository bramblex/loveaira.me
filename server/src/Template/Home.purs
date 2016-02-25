module Template.Home where

import Prelude (show)
import Data.Maybe
import Template.Base
import Model.Article (Article())

index :: Article -> Template
index homepage = do
  base
  extend "body" $ do
    t_div [a_class := [pure_g, "markdown-body"]] do
      t_div [a_class := [pure_u_1, "article-content"]] $ text homepage.content
      t_div [a_class := [pure_u_1, "article-comments"]] $ comments "homepage"
