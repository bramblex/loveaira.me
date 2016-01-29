module Data.DOM.Free where

import Prelude
import Control.Monad.Writer
import Data.Maybe
import Data.Foldable (for_)

import Control.Monad.Free

data ContentF a = TextContent String a
                | ElementContent Element a

instance functorContentF :: Functor ContentF where
  map f (TextContent s a) = TextContent s (f a)
  map f (ElementContent e a) = ElementContent e (f a)

type Content = Free ContentF

newtype Attribute = Attribute { key :: String
                              , val :: String
                              }

newtype Element = Element { name :: String
                          , attr :: Array Attribute
                          , cont :: Maybe (Content Unit)
                          }

element :: String -> Array Attribute -> Maybe (Content Unit) -> Element
element name attr cont = Element { name: name
                                 , attr: attr
                                 , cont: cont
                                 }

a :: Array Attribute -> Content Unit -> Element
a attr cont = element "a" attr (Just cont)

p :: Array Attribute -> Content Unit -> Element
p attr cont = element "p" attr (Just cont)

img :: Array Attribute -> Element
img attr = element "img" attr Nothing

text :: String -> Content Unit
text s = liftF $ TextContent s unit

elem :: Element -> Content Unit
elem e = liftF $ ElementContent e unit

newtype AttributeKey = AttributeKey String

(:=) :: AttributeKey -> String -> Attribute
(:=) (AttributeKey key) val = Attribute { key: key
                                        , val: val
                                        }
href :: AttributeKey
href = AttributeKey "href"

_class :: AttributeKey
_class = AttributeKey "class"

src :: AttributeKey
src = AttributeKey "src"

width :: AttributeKey
width = AttributeKey "width"

height :: AttributeKey
height = AttributeKey "height"

-- render dom template
render :: Element -> String
render = execWriter <<< renderElement

renderElement :: Element -> Writer String Unit
renderElement (Element e) = do
  tell "<"
  tell e.name
  for_ e.attr $ \a -> do
    tell " "
    renderAttribute a
  case e.cont of
    Nothing -> tell "/>"
    Just cont -> do
      tell ">"
      runFreeM renderContent cont
      tell $ "</" ++ e.name ++ ">"

renderAttribute :: Attribute -> Writer String Unit
renderAttribute (Attribute a) = do
  tell $ a.key ++ "=" ++ show a.val

renderContent :: ContentF (Content Unit)-> Writer String (Content Unit)
renderContent (TextContent s rest) = do
  tell s
  return rest
renderContent (ElementContent e rest) = do
  renderElement e
  return rest
