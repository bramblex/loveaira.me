module Data.DOM.Render where

import Control.Monad.Writer
import Data.Foldable (for_)

import Data.DOM.Type

render :: Element -> String
render = execWriter <<< renderElement

renderElement :: Element -> Writer String Unit
renderElement (Element e) = do
  tell $ "<" ++ e.name
  for_ e.attr $ \a -> do
    tell " "
    renderAttribute a
  case e.cont of
    Nothing -> tell "/>"
    Just cont -> do
      runFreeM renderContent cont
      tell $ "</" ++ e.name ++ ">"

renderAttribute :: Attribute -> Writer String Unit
renderAttribute (Attribute a) = do
  tell $ a.key ++ "=" ++ show a.val
renderAttribute (BooleanAttr a) = do
  tell a.key

renderContent :: ContentF (Content Unit)-> Writer String (Content Unit)
renderContent (TextContent s rest) = do
  tell s
  return rest
renderContent (ElementContent e rest) = do
  renderElement e
  return rest
