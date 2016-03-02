
module LazyLoad (loadcss, loadjs, runLazyLoad) where

import Prelude hiding (append)

import Control.Bind ((=<<))

import Control.Monad.Eff
import Control.Monad.Eff.Exception
import Control.Monad.Eff.Class
import Control.Monad.Eff.Console (log)

import Control.Monad.Eff.JQuery
import Data.Maybe

import Control.Monad.Aff
import Control.Monad.Aff.Class

import DOM

runLazyLoad = launchAff

loadcss url = void $ makeAff loadcssImpl'
  where loadcssImpl' onFailrue onSuccess =
          void $ loadcssImpl url (\_ _ -> onFailrue $ error "") (\e _ -> onSuccess e)

loadjs url = void $ makeAff loadjsImpl'
  where loadjsImpl' onFailrue onSuccess =
          void $ loadjsImpl url (\_ _ -> onFailrue $ error $ "LazyLoad: Load script " ++ url ++ " error! Load sequence stoped!") (\e _ -> onSuccess e)

loadcssImpl ::
  forall eff a. String
  -> (JQueryEvent -> JQuery -> Eff (dom :: DOM | eff) a)
  -> (JQueryEvent -> JQuery -> Eff (dom :: DOM | eff) a)
  -> Eff (dom :: DOM | eff) JQuery
loadcssImpl url onError onLoad = do
  link <- create "<link>"
  setAttr "rel" "stylesheet" link
  setAttr "href" url link
  append link =<< select "head"

  -- using img to listen the event
  img <- create "<img>"
  on "error" (onLoad) img
  setAttr "src" url img

loadjsImpl ::
  forall eff a. String
  -> (JQueryEvent -> JQuery -> Eff (dom :: DOM | eff) a)
  -> (JQueryEvent -> JQuery -> Eff (dom :: DOM | eff) a)
  -> Eff (dom :: DOM | eff) JQuery
loadjsImpl url onError onLoad = do
  script <- create "<script>"

  -- 1. append script into head
  append script =<< select "head"

  -- 2. add listener
  on "load" (onLoad) script
  on "error" (onError) script

  -- 3. add source url
  setAttr "class" "lazyload" script
  setAttr "type" "text/javascript" script
  setAttr "charset" "utf-8" script
  setAttr "src" url script

