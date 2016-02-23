module Config where

import qualified Lib.Utils as Utils

port = 8000

security_key_path = "data/security_key.js"
security_key = _getSecurityKey security_key_path

foreign import _getSecurityKey :: String -> String

database_path = Utils.projectDir "data/lovearia.db"

static_path = Utils.projectDir "static"

favicon_path = Utils.projectDir "favicon.ico"
