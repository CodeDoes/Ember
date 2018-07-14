import Base as BaseFile
import Decimal as DecimalFile
import Hexadecimal as HexadecimalFile
import Base58 as Base58File

import ../BN as BNFile

import strutils

proc verify*(base: BaseDataObj, value: string): bool {.raises: [].} =
    for i in 0 ..< value.len:
        result = false
        for s in base.sets:
            if value[i] in s.Set:
                result = true
                break

        if result != true:
            return

    result = true

proc convert*[T](base: BaseDataObj, valueArg: Decimal): T {.raises: [ValueError, OverflowError].} =
    if valueArg.value < BNNums.ZERO:
        raise newException(ValueError, "BN is negative.")

    var
        value: BN = valueArg.value
        remainder: string
    result = T()
    result.value = ""

    while value > BNNums.ONE:
        remainder = $(value mod base.base)
        value = value div base.base
        result.value = $base.characters[parseInt(remainder)] & result.value
    remainder = $(value mod base.base)
    value = value div base.base
    result.value = $base.characters[parseInt(remainder)] & result.value

    if value == BNNums.ONE:
        result.value = $base.characters[parseInt(remainder)] & result.value

    while result.value[0] == base.characters[0]:
        if result.value.len == 1:
            break
        result.value = result.value.substr(1, result.value.len)

    if base.evenLen and ((result.value.len mod 2) == 1):
        result.value = base.characters[0] & result.value

proc revert*[T](base: BaseDataObj, valueArg: T): Decimal {.raises: [ValueError].} =
    if not verify(base, valueArg.value):
        raise newException(ValueError, "Invalid Number.")

    var
        value: string = valueArg.value
        digits: BN = newBN(value.len)
        digit: int
    result = Decimal()
    result.value = newBN("0")

    for i in 0 ..< value.len:
        dec(digits)
        for s in base.sets:
            if value[i] in s.Set:
                digit = ord(value[i]) - s.value
        result.value += newBN(digit) * (base.base ^ digits)
