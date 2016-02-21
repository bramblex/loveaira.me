module Model.User where

import Prelude
import Data.Maybe
import Data.Either
import Model.Base

import Control.Monad.Aff
import Control.Monad.Aff.Console

import qualified Lib.Utils as Utils
import qualified Config as Config

type User = Record (username::String, password:: String, role::String)

newtype Password = Password String

instance isValuePassword :: IsValue Password where
  toValue (Password pw) = show $ Utils.sha1 Config.security_key pw

table_name = "user"
schema = [ "username" .=> "VARCHAR(255) UNIQUE NOT NULL"
         , "password" .=> "VARCHAR(255) NOT NULL"
         , "role" .=> "VARCHAR(255) DEFAULT \"auth\"" ]
init = do
  createTable table_name schema

findUser = find table_name
firstUser = first table_name
findallUser = findall table_name
insertUser = insert table_name
insertOrUpdateUser = insertOrUpdate table_name
updateUser = update table_name
deleteUser = delete table_name

createUser :: forall eff. String -> String -> ModelAff eff Unit
createUser username password =
  insertUser ["username" .= username, "password" .= Password password]

findUserById :: forall eff. Int -> ModelAff eff User
findUserById id =
  firstUser ("id" .== id) (Asc "id")

updateUserById :: forall eff. Int -> Array Assign -> ModelAff eff Unit
updateUserById id uv =
  updateUser uv ("id" .== id)

findUserByUsername :: forall eff. String -> ModelAff eff User
findUserByUsername username =
  firstUser ("username" .== username) (Asc "id")

authorization :: forall eff. Maybe String -> Maybe String -> ModelAff eff (Maybe User)
authorization (Just username) (Just password) = do
  result <- attempt $ findUserByUsername username
  case result of
    Right user ->
      if user.password == Utils.sha1 Config.security_key password
      then return (Just user)
      else return Nothing
    Left _ -> return Nothing
authorization _ _ = return Nothing

changePassword :: forall eff. Int -> Maybe String -> Maybe String -> ModelAff eff Boolean
changePassword id (Just newpassword) (Just repeated) =
  case newpassword == repeated && newpassword /= "" of
    true -> do
      updateUserById id ["password" .= Password newpassword]
      return true
    false -> do
      return false
changePassword _ _ _ = return false

reloadUser :: forall eff. User -> ModelAff eff User
reloadUser user = do
  findUserById user.id
