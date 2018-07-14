import Base as BaseFile
import Logic

import ../BN as BNFile

type Base58* = ref object of RootObj
    value*: string

var Base58Data*: BaseDataObj = BaseDataObj(
    base: newBN(58),
    characters: @[
        '1', '2', '3', '4', '5', '6', '7', '8', '9',
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J',
        'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T',
        'U', 'V', 'W', 'X', 'Y', 'Z',
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
        'j', 'k', 'm', 'n', 'o', 'p', 'q', 'r', 's',
        't', 'u', 'v', 'w', 'x', 'y', 'z'
    ],
    sets: @[
        SetValue({'1' .. '9'}, 49),
        SetValue({'A' .. 'H'}, 56),
        SetValue({'J' .. 'N'}, 57),
        SetValue({'P' .. 'Z'}, 58),
        SetValue({'a' .. 'k'}, 64),
        SetValue({'m' .. 'z'}, 65)
    ],
    evenLen: false
)

proc newBase58*(value: string): Base58 {.raises: [ValueError].} =
    var valid: bool
    for i in 0 ..< value.len:
        valid = false
        for s in Base58Data.sets:
            if value[i] in s.Set:
                valid = true
                break
        if valid != true:
            raise newException(ValueError, "Invalid Base58.")

    result = Base58(
        value: value
    )
