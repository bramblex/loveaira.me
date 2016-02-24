module Lib.Utils where

import Prelude
import Control.Monad.Eff
import Data.Foldable
import Data.String (drop, length)

import Data.Either
import Data.Maybe

join :: String -> Array String -> String
join sp arr = drop (length sp) $ foldl (\l s -> l ++ sp ++ s) "" arr

join' :: Array String -> String
join' = join ", "

join_ :: Array String -> String
join_ = join " "

concatMap :: forall a b. (a -> Array b) -> Array a -> Array b
concatMap = flip bind

import Data.Maybe
import Data.Int
parseInt :: String -> Int
parseInt str = fromMaybe 0 $ fromString str

projectDir :: forall eff. String -> Eff (current::CURRENT | eff) String
projectDir path = do
  root_path <- __toplevel
  return $ join "/" [root_path, "website", path]

eitherToMaybe :: forall a e. Either e a -> Maybe a
eitherToMaybe (Left _)  = Nothing
eitherToMaybe (Right v) = Just v

-- testProjectDir :: forall eff. String -> Eff (current::CURRENT | eff) String
-- testProjectDir path = do
--   root_path <- __toplevel
--   return $ join "/" [root_path, "website", path]

foreign import data CURRENT :: !

foreign import sha1 :: String -> String -> String

foreign import __filename :: forall eff. Eff (current::CURRENT | eff) String
foreign import __dirname :: forall eff. Eff (current::CURRENT | eff) String
foreign import __toplevel  :: forall eff. Eff (current::CURRENT | eff) String

foreign import merge :: forall t1 t2 t3. {|t1}-> {|t2} -> {|t3}

foreign import encodeURIComponent :: String -> String
foreign import encodeURI :: String -> String
foreign import decodeURIComponent :: String -> String
foreign import decodeURI :: String -> String

foreign import escapeString :: String -> String

foreign import randString :: forall eff. Int -> Eff (current::CURRENT | eff) String

foreign import mdToHtml  :: String -> String

foreign import repeat :: Int -> String -> String

foreign import _require :: String -> String

foreign import runcmd :: forall eff. String -> Eff (current::CURRENT | eff) String

foreign import reomveArgsFromPath :: String -> String
