module Model.User where

import Prelude
import Data.Maybe
import Model.Base

import qualified Lib.Utils as Utils
import qualified Config as Config

type User = Record (username::String, password:: String)

newtype Password = Password String

instance isValuePassword :: IsValue Password where
  toValue (Password pw) = Utils.sha1 Config.security_key pw

table_name = "user"
schema = [ "username" .= "VARCHAR(255) UNIQUE NOT NULL"
         , "password" .= "VARCHAR(255) NOT NULL" ]

findUser = find table_name
firstUser = first table_name
findallUser = findall table_name
insertUser = insert table_name
updateUser = update table_name
deleteUser = delete table_name

createUser :: forall eff. String -> String -> ModelAff eff Unit
createUser username password =
  insertUser ["username" .= username, "password" .= Password password]

findUserById :: forall eff. Int -> ModelAff eff User
findUserById id =
  firstUser ("id" .== id) (Asc "id")

findUserByUsername :: forall eff. String -> ModelAff eff User
findUserByUsername username =
  firstUser ("username" .== username) (Asc "id")

authorization :: forall eff. String -> String -> ModelAff eff (Maybe User)
authorization username password = do
  user <- findUserByUsername username
  if user.password == Utils.sha1 Config.security_key password
    then return (Just user)
    else return (Nothing)
