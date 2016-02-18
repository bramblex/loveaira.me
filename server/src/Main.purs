module Main where

import Prelude hiding (apply)
import Control.Monad.Eff
import Control.Monad.Eff.Console

import Control.Monad.Aff

import Node.Express.App
import Node.HTTP (Server())

import Data.Maybe
import Data.Either
import Control.Monad.Eff.Exception (EXCEPTION())
import Node.Yargs.Setup
import Node.Yargs.Applicative

import qualified Config as Config
import qualified App as App
import qualified Lib.Utils as Utils
import qualified Init as Init

import Handler.Base

type MainEff eff a = HandlerEff (console::CONSOLE, err::EXCEPTION | eff) a

runServer :: forall eff. MainEff eff Unit
runServer = do
  server <- listenHttp App.main Config.port \_ -> log $ "Listening on prot: " ++ show Config.port
  log $ "Server start"

runInit :: forall eff. MainEff eff Unit
runInit = do
  log $ "Run Init"
  launchAff Init.main

createUser :: forall eff. String -> MainEff eff Unit
createUser user = launchAff $ Init.createUser user

import qualified Lib.Utils as Utils

runMain :: forall eff. Boolean -> Array String -> MainEff eff Unit
runMain false _ = runServer
runMain true [] = runInit
runMain true [user] = createUser user

main :: forall eff. MainEff eff Unit
main = let setup = usage "$0 / $0 -i"
       in runY setup $ runMain
          <$> flag "i" ["init"] (Just "Run Init")
          <*> yarg "u" ["user"] (Just "Init with User") (Left []) false

-- import Template.Base as T
-- import Data.DOM.Render as R
-- main = print $ R.getExtend T.index

-- main = log $ whole 1
-- main = log "hello"

-- whole :: Int -> String
-- whole = runfuck >>> unfuck

-- foreign import fuckingUndefined :: Int -> Foreign


-- import Control.Monad.Eff
-- import Control.Monad.Eff.Console
-- import Control.Monad.Eff.Exception (EXCEPTION())

-- app :: forall eff. Array String -> Boolean -> Eff (console :: CONSOLE | eff) Unit
-- app [] _     = return unit
-- app ss false = print ss
-- app ss true  = print (reverse ss)

-- main :: forall eff. Eff ( console :: CONSOLE, err :: EXCEPTION | eff) Unit
-- main = do
--   let setup = usage "$0 -w Word1 -w Word2"
--               <> example "$0 -w Hello -w World" "Say hello!"

--   runY setup $ app <$> yarg "w" ["word"] (Just "A word") (Right "At least one word is required") false
--                    <*> flag "r" []       (Just "Reverse the words")
