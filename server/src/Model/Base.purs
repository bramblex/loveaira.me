module Model.Base where

import Prelude
import Data.Tuple
import Data.Foldable (foldl)
import Data.String (drop, length)

import Database.SQLite

type Date = String
type Record t = Row (id :: Int, create_at :: Date, update_at :: Date | t)

type Table = String
type Column = String
type QValue = String

data Condition = Eq Column QValue
               | Gt Column QValue
               | Gte Column QValue
               | Lt Column QValue
               | Lte Column QValue

class IsValue a where
  toValue :: a -> QValue

instance isValueInt :: IsValue Int where
  toValue = show

instance isValueString :: IsValue String where
  toValue = show

(.=) :: forall a. (IsValue a) => Column -> a -> Condition
(.=) c v = Eq c (toValue v)

(.>) :: forall a. (IsValue a) => Column -> a -> Condition
(.>) c v = Gt c (toValue v)

(.<) :: forall a. (IsValue a) => Column -> a -> Condition
(.<) c v = Lt c (toValue v)

(.>=) :: forall a. (IsValue a) => Column -> a -> Condition
(.>=) c v = Gte c (toValue v)

(.<=) :: forall a. (IsValue a) => Column -> a -> Condition
(.<=) c v = Lte c (toValue v)

class Relation f where
  (.&&) :: forall a. f a -> a -> f a
  (.||) :: forall a. f a -> a -> f a
  with :: forall a. a -> f a

type Conditions = ConditionsR Condition
data ConditionsR c = CAnd (ConditionsR c) c
         | COr (ConditionsR c) c
         | Where c

type Set = SetR Condition
data SetR c = SAnd (SetR c) c
            | Set c

type Value = ValueR Condition
data ValueR c = VAnd (ValueR c) c
              | Value c

instance relationConditionsR :: Relation ConditionsR where
  (.&&) r c = CAnd r c
  (.||) r c = COr r c
  with = Where

instance relationSetR :: Relation SetR where
  (.&&) r c = SAnd r c
  (.||) r c = r .&& c
  with = Set

instance relationValueR :: Relation ValueR where
  (.&&) r c = VAnd r c
  (.||) r c = r .&& c
  with = Value

data Order = Asc | Desc
data OrderBy = OrderBy Column Order

data Limit = Limit Int Int

data Query = Find Table Conditions OrderBy Limit
           | Insert Table Value
           | Update Table Set Conditions
           | Delete Table Conditions
           | Count Table Conditions

join :: String -> Array String -> String
join sp arr = drop (length sp) $ foldl (\l s -> l ++ sp ++ s) "" arr

join' :: Array String -> String
join' = join ", "

join_ :: Array String -> String
join_ = join " "

class ToSql f where
  tosql :: f -> Sql

instance toSqlLimit :: ToSql Limit where
  tosql (Limit offset count) = join_ ["LIMIT", join' [show offset, show count]]

instance toSqlOrderBy :: ToSql OrderBy where
  tosql (OrderBy col order) = join_ ["ORDER BY", col, order']
    where order' = case order of
            Asc -> "ASC"
            Desc -> "DESC"

instance toSqlCondition :: ToSql Condition where
  tosql c = case c of
    Eq col v -> join_ [col, "=", v]
    Gt col v -> join_ [col, ">", v]
    Gte col v -> join_ [col, ">=", v]
    Lt col v -> join_ [col, "<", v]
    Lte col v -> join_ [col, "<=", v]

instance toSqlConditions :: ToSql (ConditionsR Condition) where
  tosql cs = case cs of
    CAnd cs c -> join_ [tosql cs, "AND", tosql c]
    COr cs c -> join_ [tosql cs, "OR", tosql c]
    Where c -> join_ ["WHERE", tosql c]

instance toSqlSet :: ToSql (SetR Condition) where
  tosql s = case s of
    SAnd s c -> join ", " [tosql s, tosql c]
    Set c -> join_ ["SET", tosql c]

unpack :: Value -> Tuple (Array Column) (Array QValue)
unpack v = case v of
  VAnd v c -> let cols = fst rs ++ [fst r]
                  vals = snd rs ++ [snd r]
                  r = unpackc c
                  rs = unpack v
              in Tuple cols vals
  Value c -> let r = unpackc c
                 col = fst r
                 val = snd r
             in Tuple [col] [val]
  where unpackc c = case c of
          Eq col val -> Tuple col val

instance toSqlValue :: ToSql (ValueR Condition) where
  tosql v = join_ ["(", join' cols, ")", "VALUES", "(", join' vals, ")"]
    where rs = unpack v
          cols = fst rs
          vals = snd rs

instance toSqlQuery :: ToSql Query where
  tosql query = case query of
    Find t cs o l -> join_ ["SELECT * FROM", t, tosql cs, tosql o, tosql l]
    Insert t v -> join_ ["INSERT INTO", t, tosql v]
    Update t s cs -> join_ ["UPDATE", t, tosql s, tosql cs]
    Delete t cs -> join_ ["DELETE", t, tosql cs]
    Count t cs -> join_ ["SELECT COUNT(*) FROM", t, tosql cs]
