module Config where

import qualified Lib.Utils as Utils

port = 8000

security_key = "keyborad cat"

database_path = Utils.projectDir "data/lovearia.db"

static_path = Utils.projectDir "static"

favicon_path = Utils.projectDir "favicon.ico"
