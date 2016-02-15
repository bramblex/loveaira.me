module Main where

import Prelude hiding (apply)
import Control.Monad.Eff
import Control.Monad.Eff.Console

import Control.Monad.Aff

import Node.Express.App
import Node.HTTP (Server())

import Data.Maybe
import Node.Yargs.Setup
import Node.Yargs.Applicative

import qualified Config as Config
import qualified App as App
import qualified Lib.Utils as Utils
import qualified Init as Init

import Handler.Base

runServer = do
  server <- listenHttp App.main Config.port \_ -> log $ "Listening on prot: " ++ show Config.port
  log $ "Server start"
runInit = do
  log $ "Run Init"
  launchAff Init.main

runMain true = runInit
runMain init = runServer

main = let setup = usage "$0 / $0 -i"
       in runY setup $ runMain <$> flag "i" ["init"] (Just "Run Init")

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
