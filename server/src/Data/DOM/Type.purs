module Data.DOM.Type where

import Prelude
import Data.Maybe

import Control.Monad.Free

data ContentF a = TextContent String a
                | ElementContent Element a
                | BlockContent Block a
                | ExtendContent Block a

instance functorContentF :: Functor ContentF where
  map f (TextContent s a) = TextContent s (f a)
  map f (ElementContent e a) = ElementContent e (f a)
  map f (BlockContent b a) = BlockContent b (f a)
  map f (ExtendContent b a) = ExtendContent b (f a)

type Content = Free ContentF

data Attribute = Attribute { key :: String , val :: String }
               | BooleanAttr { key :: String }

newtype Element = Element { name :: String
                          , attr :: Array Attribute
                          , cont :: Maybe (Content Unit) }

newtype Block = Block { name :: String
                      , cont :: Maybe (Content Unit) }

(.<-) name cont = Block {name: name, cont: Just cont}

instance showBlock :: Show Block where
  show (Block b) = "Block: " ++ show b.name
