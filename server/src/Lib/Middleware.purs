module Lib.Middleware where

import Prelude
import Data.Function
import Node.Express.Types

foreign import bodyParser :: forall e t. {|t} -> Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)

foreign import static :: forall e t. Path -> Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)

foreign import  setCookiesMaxAge  :: forall e t. Int -> Fn3 Request Response (ExpressM e Unit) (ExpressM e Unit)
