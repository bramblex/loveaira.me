module Main where

import Prelude hiding (apply)
import Control.Monad.Eff

import Control.Monad.Eff.Console

import Data.Maybe
import Data.Either
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Data.Monoid (mempty, Monoid)
import Data.Function
-- import Control.Monad.Eff.Class
-- import Control.Monad.Eff.Console (CONSOLE(), log)
import Control.Monad.Eff.Console as C
-- import Control.Monad.Aff.Console (log, print)
import Node.Express.Types
import Node.Express.App
import Node.Express.Handler
import Node.Express.Request
import Node.Express.Response
import Node.HTTP (Server())

import Control.Monad.Aff
import Control.Monad.Aff.Class

import Control.Monad.Eff.Class
import Control.Monad.Trans

-- import Control.Monad.Eff.Exception
-- import Control.Monad.Error.Class

import Lib.Utils
import Model.Base hiding (delete)

import Config (port)

-- main = launchAff $ do
--   str <- getDBPath
--   liftEff $ C.log str

indexHandler :: forall eff. Handler (database :: DATABASE, current :: CURRENT |eff)
indexHandler = do
  record <- liftAff $ first "Test" ("id" .> 0) (Desc "id")
  sendJson record

echoHandler :: forall eff. Handler eff
echoHandler = do
  msg <- getBodyParam "message"
  case msg of
    Nothing -> send "Nothing"
    Just m -> send $ "aaa" ++ m

-- app :: forall eff. App (console :: CONSOLE | eff)
app = do
  liftEff $ log "Setting up"
  -- useExternal bodyParser
  get "/" indexHandler
  post "/" echoHandler

-- main :: forall eff. Eff (express :: EXPRESS, console :: CONSOLE | eff) Server
main = listenHttp app port \_ -> log $ "Listening on prot: " ++ show port

-- import Data.Function

-- foreign import __setTimeout ::
--   forall eff t. Fn3 Int
--   (Error -> Eff eff Unit)
--   (t -> Eff eff Unit)
--   (Eff eff Unit)

-- delay :: forall eff. Int -> Aff eff Unit
-- delay n = makeAff $ runFn3 __setTimeout n

-- job :: forall eff. Aff (console::C.CONSOLE | eff) Unit
-- job = do
--   delay 1000
--   liftEff $ C.log "Hello World!"
--   delay 1000
--   liftEff $ C.log "Hello World!"
--   throwError $ error "TestError"

-- import Database.SQLite

-- job :: forall eff. Aff (database::DATABASE, console::C.CONSOLE | eff) Unit
-- job = do
--   db <- connectDB "/tmp/test.db" default_mode
--   row <- getDB db "select * from lorem"
--   liftEff $ C.log (row.id ++ "|"++ row.info)

-- getDBFullPath :: forall eff. Aff eff String
-- getDBFullPath = do
--   root_path <- liftEff __dirname
--   return $ join "/" [root_path, database_path]

-- job :: forall eff. Aff (console::C.CONSOLE, current::CURRENT | eff) Unit
-- job = do
--   str <-  liftEff __dirname
--   liftEff $ C.log str

-- main = launchAff $ do
--   job

-- main = C.print ("test")


-- import Data.Foldable (for_, sequence_, foldl, Foldable)

-- import Control.Monad.Aff
-- import Control.Monad.Aff.Class

-- import Data.DOM.Render

-- import Data.DOM.Tags (Template(), html, head, body, h1, text, script', ul, li)
-- import Data.DOM.Attributes ((:=), _class, src)
-- import Model.Base hiding (delete)
-- import Control.Monad.Trans
-- import Lib.Utils

-- import Template.Base

-- foreign import bodyParser :: forall eff. Fn3 Request Response (ExpressM eff Unit) (ExpressM eff Unit)

-- type Test = Record (info :: String)

-- doc :: Array Test -> Template
-- doc ts = ul [] do
--   forT ts \t ->
--     li [] $ text $ join "," [show t.id, t.info]

-- main = runAsync query next
--   where query = do
--           insert "Test" (by ("info" .= "something"))
--           rows <- findall "Test" (by ("id" .> 0)) (OrderBy "id" Asc)
--           return rows
--         next (Right ts) = log (render $ doc ts)


-- main = do
--   log "start"
--   for [1, 2, 3] \n -> do
--     log (show n)

-- import Prelude
-- import Data.Foldable (foldl)
-- import Control.Monad.Eff
-- import Control.Monad.Eff.Console

-- import Data.Either
-- import Data.Either

-- import Control.Monad.Cont.Trans
-- import Control.Monad.Except.Trans

-- import Data.DOM.Render (render)
-- import Data.DOM.Tags (Template(), img, p, text, a)
-- import Data.DOM.Attributes (src, _class, (:=))

-- doc :: Template
-- doc = do
--   a [ _class := "Class" ] do
--     text "Somethings"
--   p [ _class := "first_class" ] $ do
--     img [ src := "cat.jpg" ]
--     text "A cat"
--   p [ _class := "last_class" ] $ do
--     img [ src := "dog.jpg" ]
--     text "A dog"

-- import Lib.Utils
-- import Model.Base

-- insertTest :: forall eff. DBAsync eff String
-- insertTest = do
--   createTable "Test" ["info" .= "TEXT"]
--   delete "lorem" (by ("id" .> 1) .&& ("info" .= "Test"))
--   return "success"

-- insertTest :: forall eff. DBAsync eff String
-- insertTest = getDBFullPath

-- main :: forall eff. Eff (console :: CONSOLE , database :: DATABASE | eff) Unit
-- main = runAsync insertTest result
--        where result (Right str) = print str
--              result (Left err) = print err.message

-- main = log "hello"
-- main = log $ render $
--        a [_class := "main", href := "http://baidu.com"] [text "Hello World!"]

-- import SQLite

-- type Lorem = Row (info :: String)

-- insertTest :: forall eff. String -> ExceptT ErrorCode (ContT Unit (Eff eff)) (Array Lorem)
-- insertTest info = do
--   db <- connectContEx "/tmp/test.db" default_mode
--   rows <- allContEx db $ "select * from lorem where `info` = \""++ info ++"\""
--   return rows

-- main :: forall e. Eff (console :: CONSOLE | e) Unit
-- main = do
--   runAsyncEx (insertTest "再试试") $ next
--     where next (Right rows) =
--             foldl
--             (\l row-> l >>= (\_ -> (log $ show row.id ++ "|" ++ row.info )))
--             (log "123") rows
--           next (Left err) = error err

-- main = flip runContT print . runExceptT $ insertTest

-- foreign import data ALERT :: !
-- foreign import alert :: forall e. String -> Eff (console :: CONSOLE | e) Unit

-- foreign import setTimeout :: forall eff. Fn2 Int
--                              (Eff eff Unit)
--                              (Eff eff Unit)

-- foreign import data HRec :: * -> *
-- foreign import empty :: forall a. HRec a
-- foreign import insert :: forall a. Fn3 String a (HRec a) (HRec a)
-- foreign import showHRec :: forall a. Fn1 (HRec a) String

-- iEmpty :: HRec Int
-- iEmpty = empty

-- iInsert :: String -> Int -> (HRec Int) -> (HRec Int)
-- iInsert = runFn3 insert

-- iShowHRec :: (HRec Int) -> String
-- iShowHRec = runFn1 showHRec

-- foreign import data DB :: *

-- foreign import connect :: forall e. Fn2 String
--                           (DB -> Eff e Unit)
--                           (Eff e Unit)

-- foreign import run :: forall e. Fn3 DB String
--                           (Eff e Unit)
--                           (Eff e Unit)

-- foreign import isOpen :: forall e. Fn1 DB (Eff e Unit)
-- foreign import close :: forall e. Fn1 DB (Eff e Unit)
