import ../BN as BNFile

type
    SetValueObj* = ref object of RootObj
        Set*: set[char]
        value*: int
    BaseDataObj* = object of RootObj
        base*: BN
        characters*: seq[char]
        sets*: seq[SetValueObj]
        evenLen*: bool

proc SetValue*(Set: set[char], value: int): SetValueObj =
    result = SetValueObj(
        Set: Set,
        value: value
    )
