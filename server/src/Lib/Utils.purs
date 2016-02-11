module Lib.Utils where

import Prelude
import Control.Monad.Eff
import Data.Foldable (foldl)
import Data.String (drop, length)

join :: String -> Array String -> String
join sp arr = drop (length sp) $ foldl (\l s -> l ++ sp ++ s) "" arr

join' :: Array String -> String
join' = join ", "

join_ :: Array String -> String
join_ = join " "

foreign import data CURRENT :: !

foreign import __filename :: forall eff. Eff (current::CURRENT | eff) String

foreign import __dirname :: forall eff. Eff (current::CURRENT | eff) String

foreign import sha1 :: String -> String -> String
