module Data.DOM.Type where

import Prelude
import Data.Maybe

import Control.Monad.Free

data ContentF a = TextContent String a
                | ElementContent Element a

instance functorContentF :: Functor ContentF where
  map f (TextContent s a) = TextContent s (f a)
  map f (ElementContent e a) = ElementContent e (f a)

type Content = Free ContentF

data Attribute = Attribute { key :: String , val :: String }
               | BooleanAttr { key :: String }

newtype Element = Element { name :: String
                          , attr :: Array Attribute
                          , cont :: Maybe (Content Unit)
                          }

element :: String -> Array Attribute -> Maybe (Content Unit) -> Element
element name attr cont = Element { name: name
                                 , attr: attr
                                 , cont: cont
                                 }


text :: String -> Content Unit
text s = liftF $ TextContent s unit

elem :: Element -> Content Unit
elem e = liftF $ ElementContent e unit
