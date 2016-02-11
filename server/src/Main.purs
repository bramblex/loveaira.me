module Main where

import Prelude hiding (apply)
import Control.Monad.Eff.Console

import Node.Express.App
import Node.HTTP (Server())

import qualified Config as Config
import qualified App as App

main = listenHttp App.main Config.port \_ -> log $ "Listening on prot: " ++ show Config.port
