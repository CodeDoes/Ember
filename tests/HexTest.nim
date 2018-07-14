import ../src/lib/Bases

var HexCharacters: array[16, char] = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'A', 'B', 'C', 'D', 'E', 'F'
]

type PairObj = object
    value: Decimal
    target: string
proc Pair(value: Decimal, target: string): PairObj =
    result = PairObj(
        value: value,
        target: target
    )

var
    tempHex: Hexadecimal
    tempDecimal: Decimal
proc test(pair: PairObj): string =
    result = ""

    tempHex = pair.value
    if pair.target != $tempHex:
        result = "Conerted to " & $tempHex & "."
        return

    tempDecimal = tempHex
    if pair.value != tempDecimal:
        result = "Reverted to " & $tempDecimal & "."
        return

proc suite*(): string =
    var pairs: seq[PairObj] = @[
        Pair(newBN(17), "11"),
        Pair(newBN(240), "F0"),
        Pair(newBN(255), "FF")
    ]

    for i in 0 ..< HexCharacters.len:
        var target = $HexCharacters[i]
        if (target.len mod 2) != 0:
            target = "0" & target
        pairs.add(
            Pair(newBN(i), target)
        )

    for pair in pairs:
        result = test(pair)
        if result != "":
            result =
                "Hex Test with a value of: " & $pair.value &
                " and target of: " & pair.target &
                " failed. Error: " & result
            return

    result = ""

when isMainModule:
    var res: string = suite()
    if res == "":
        echo "Success"
    else:
        echo res
