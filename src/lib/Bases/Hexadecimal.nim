import Base as BaseFile
import Logic

import ../BN as BNFile

type Hexadecimal* = ref object of RootObj
    value*: string

var HexadecimalData*: BaseDataObj = BaseDataObj(
    base: newBN(16),
    characters: @[
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
        'A', 'B', 'C', 'D', 'E', 'F'
    ],
    sets: @[
        SetValue({'0' .. '9'}, 48),
        SetValue({'A' .. 'F'}, 55),
        SetValue({'a' .. 'f'}, 87)
    ],
    evenLen: true
)

proc newHexadecimal*(value: string): Hexadecimal {.raises: [ValueError].} =
    var valid: bool
    for i in 0 ..< value.len:
        valid = false
        for s in HexadecimalData.sets:
            if value[i] in s.Set:
                valid = true
                break
        if valid != true:
            raise newException(ValueError, "Invalid Hexadecimal.")

    result = Hexadecimal(
        value: value
    )

proc `==`*(x: Hexadecimal, y: Hexadecimal): bool {.raises: [].} =
    result = x.value == y.value
proc `!=`*(x: Hexadecimal, y: Hexadecimal): bool {.raises: [].} =
    result = x.value != y.value

proc `<`*(x: Hexadecimal, y: Hexadecimal): bool {.raises: [ValueError].} =
    result = revert[Hexadecimal](HexadecimalData, x) < revert[Hexadecimal](HexadecimalData, y)
proc `<=`*(x: Hexadecimal, y: Hexadecimal): bool {.raises: [ValueError].} =
    result = revert[Hexadecimal](HexadecimalData, x) <= revert[Hexadecimal](HexadecimalData, y)

proc `>`*(x: Hexadecimal, y: Hexadecimal): bool {.raises: [ValueError].} =
    result = revert[Hexadecimal](HexadecimalData, x) > revert[Hexadecimal](HexadecimalData, y)
proc `>=`*(x: Hexadecimal, y: Hexadecimal): bool {.raises: [ValueError].} =
    result = revert[Hexadecimal](HexadecimalData, x) >= revert[Hexadecimal](HexadecimalData, y)
