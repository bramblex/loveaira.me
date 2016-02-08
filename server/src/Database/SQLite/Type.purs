module Database.SQLite.Type where

import Control.Monad.Eff

type FilePath = String
type Sql = String
type Mode = Int
type Row t = { | t }
type Param = String
type ParamList = Array Param
type ParamMap t = { | t }

foreign import data DB :: *
foreign import data DATABASE :: !
type DBEff eff = Eff (database :: DATABASE | eff)

foreign import memory_db :: FilePath
foreign import open_readonly_mode :: Mode
foreign import open_readwrite_mode :: Mode
foreign import open_create_mode :: Mode
foreign import default_mode :: Mode
