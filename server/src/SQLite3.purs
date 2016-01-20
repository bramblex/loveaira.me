module SQLite3 where

foreign import data DB :: !

type ErrorCode = String
type FilePath = String
type SQLString = String


type Recoder t = { firstName:: String, lastName :: String | t }
type Rows t = [Recoder t]

foreign import connect ::
        forall e. Fn3 FilePath
                      (DB -> Eff (db :: DB | e) Unit)
                      (ErrorCode -> Eff (db :: DB | e))
                      (Eff (db :: DB | e))

foreign import close ::
        forall e. Fn3 DB
                      (Eff (db :: DB | e) Unit)
                      (ErrorCode -> Eff (db :: DB | e))
                      (Eff (db :: DB | e))

foreign import run ::
        forall e. Fn4 DB SQLString
                      (Eff (db :: DB | e) Unit)
                      (ErrorCode -> Eff (db :: DB | e))
                      (Eff (db :: DB | e))

foreign import get
        forall e. Fn4 DB SQLString
                      (Row -> Eff (db :: DB | e) Unit)
                      (ErrorCode -> Eff (db :: DB | e))
                      (Eff (db :: DB | e))

foreign import all
        forall e. Fn4 DB SQLString
                      (Rows -> Eff (db :: DB | e) Unit)
                      (ErrorCode -> Eff (db :: DB | e))
                      (Eff (db :: DB | e))
