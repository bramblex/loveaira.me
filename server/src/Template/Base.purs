module Template.Base ( module Data.DOM.Tags
                     , module Data.DOM.Attributes
                     , module Prelude) where

import Prelude
import Data.Maybe
import Data.Foldable (foldl)
import Data.DOM.Tags
import Data.DOM.Attributes

forT :: forall t. Array t -> (t -> Template) -> Template
forT ts f = foldl (\l a -> l >>= (\_ -> f a)) (text "") ts

-- forT' :: forall t. Maybe (Array t) -> (t -> Template) -> Template
-- forT' (Nothing) f = forT [] f
-- forT' (Just ts) f = forT ts f

-- base_template :: Template
-- base_template = html [] do
--   head [] do
--     script' [src := "/static/main.js"]
--   body [] do
--     h1 [] do
--       text "卧槽"
