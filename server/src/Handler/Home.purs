module Handler.Home where

import Handler.Base
import qualified Template.Home as T

main = do
  render T.index
