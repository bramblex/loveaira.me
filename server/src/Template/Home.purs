module Template.Home where

import Prelude (show)
import Data.Maybe
import Template.Base
import Model.Article (Article())

index :: Article -> Template
index homepage = do
  base
  extend "body" $ do
    text homepage.content
