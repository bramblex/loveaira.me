module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console

foreign import data ALERT :: !
foreign import alert :: forall e. String -> Eff (alert :: ALERT | e) Unit

main :: forall e. Eff (alert :: ALERT | e) Unit
main = do
    alert "hello"
    {--log "Hello sailor!"--}
