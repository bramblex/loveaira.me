module Data.DOM.Render where

import Prelude

import Data.Maybe
import Data.Foldable (find, for_)

import Control.Monad.Writer
import Control.Monad.Writer.Trans

import Control.Monad.State
import Control.Monad.State.Trans

import Control.Monad.Reader
import Control.Monad.Reader.Trans

import Control.Monad.Trans

import Control.Monad.Free

import Data.DOM.Type
import Data.DOM.Tags (Template(), text, elem, block, extend)

import Lib.CookieSession (Session(..), empty_session)

type Interp = WriterT String (ReaderT (Array Block) (State Session))

render :: Session -> Template -> String
render session cont = let blocks = getExtend cont
              in evalState (flip runReaderT blocks (execWriterT (runFreeM renderContent cont))) session

renderElement :: Element -> Interp Unit
renderElement (Element e) = do
  tell $ "<" ++ e.name
  for_ e.attr $ \a -> do
    tell " "
    renderAttribute a
  case e.cont of
    Nothing -> tell "/>"
    Just cont -> do
      tell ">"
      runFreeM renderContent cont
      tell $ "</" ++ e.name ++ ">"

lookupBlockContent :: String -> Array Block -> Maybe Template
lookupBlockContent name = b2t <<< find (\(Block b) -> b.name == name)
  where b2t (Just (Block b)) = b.cont
        b2t _ = Nothing

altMaybe :: forall a. Maybe a -> Maybe a -> Maybe a
altMaybe (Just a) _ = Just a
altMaybe Nothing b = b

renderBlock :: Block -> Interp Unit
renderBlock (Block b) = do
  ret :: Array Block <- ask
  let cont = lookupBlockContent b.name ret
  case altMaybe cont b.cont of
    Nothing -> tell ""
    Just cont' -> do
      runFreeM renderContent cont'
      return unit

renderAttribute :: Attribute -> Interp Unit
renderAttribute (Attribute a) = do
  tell $ a.key ++ "=" ++ a.val
renderAttribute (BooleanAttr a) = do
  tell a.key

renderContent :: forall a. ContentF (Content a) -> Interp (Content a)
renderContent (TextContent s rest) = do
  tell s
  return rest
renderContent (ElementContent e rest) = do
  renderElement e
  return rest
renderContent (BlockContent b rest) = do
  renderBlock b
  return rest
renderContent (ExtendContent _ rest) = do
  return rest
renderContent (GetSession k) = do
  session :: Session <- get
  return (k session)

getExtend :: Template -> Array Block
getExtend cont = execWriter (runFreeM getExtendW cont)

getExtendW :: forall a. ContentF (Content a) -> Writer (Array Block) (Content a)
getExtendW (TextContent s rest) = do
  return rest
getExtendW (ExtendContent b rest) = do
  tell [b]
  return rest
getExtendW (BlockContent b rest) = do
  return rest
getExtendW (ElementContent e rest) = do
  getExtendFromElement e
  return rest
getExtendW (GetSession k) = do
  return $ k empty_session

getExtendFromElement :: Element -> Writer (Array Block) Unit
getExtendFromElement (Element e) = do
  case e.cont of
    Nothing -> return unit
    Just cont -> do
      runFreeM getExtendW cont
      return unit
