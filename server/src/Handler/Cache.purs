module Handler.Cache where

import Handler.User (requireLogin)
import Handler.Base
import Lib.Cache
import Data.Tuple
import Control.Monad.Eff.Console

main = do
  get "/clean" $ requireLogin clean

clean = do
  liftEff cleanCached
  send "Clean success!"

cacheMiddleware = do
  path <- getOriginalUrl
  method <- getMethod
  is_login <- isLogin

  case method of
    Just GET -> do
      r <- liftEff $ getCached path
      case r of
        Just page -> do
          if is_login
            then return unit
            else liftEff $ log $ "cache hit: " ++ path
          send page
        _ -> next
    _ -> next

logger = do
  path <- getOriginalUrl
  method <- getMethod
  case method of
    Just m -> liftEff $ log $ show m ++ ": " ++ path
    _ -> return unit
  next
-- main :: forall eff. ModelApp eff
-- main = do
--   get "/" $ send "test"
--   get "/set/:key/:val" set
--   get "/view/:key" view
--   get "/clean" clean

-- set = do
--   Tuple (Just key) (Just val) <- Tuple <$> getRouteParam "key" <*> getRouteParam "val"
--   liftEff $ cache 30 key val
--   send $ key ++ ": " ++ val

-- view = do
--   (Just key) <- getRouteParam "key"
--   val <- liftEff $ getCached key
--   case val of
--     Just val' -> send $ key ++ ": " ++ val'
--     Nothing -> send $ "Has not cached " ++ key

-- clean = do
--   liftEff $ cleanCached
--   send "clean"
