module Database.SQLite.FnImpl where

import Prelude
import Data.Function
import Data.Either

runFn6Impl fn a1 a2 a3 a4 k = runFn6 fn a1 a2 a3 a4 (k <<< Right) (k <<< Left)
runFn5Impl fn a1 a2 a3 k = runFn5 fn a1 a2 a3 (k <<< Right) (k <<< Left)
runFn4Impl fn a1 a2 k = runFn4 fn a1 a2 (k <<< Right) (k <<< Left)
runFn3Impl fn a1 k = runFn3 fn a1 (k <<< Right) (k <<< Left)
runFn2Impl fn k = runFn2 fn (k <<< Right) (k <<< Left)

runFn6Impl' fn a1 a2 a3 a4 k = runFn6 fn a1 a2 a3 a4 (k $ Right unit) (k <<< Left)
runFn5Impl' fn a1 a2 a3 k = runFn5 fn a1 a2 a3 (k $ Right unit) (k <<< Left)
runFn4Impl' fn a1 a2 k = runFn4 fn a1 a2 (k $ Right unit) (k <<< Left)
runFn3Impl' fn a1 k = runFn3 fn a1 (k $ Right unit) (k <<< Left)
runFn2Impl' fn k = runFn2 fn (k $ Right unit) (k <<< Left)
