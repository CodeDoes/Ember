import ../src/lib/Bases

var Base58Characters: array[58, char] = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J',
    'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
    'j', 'k', 'm', 'n', 'o', 'p', 'q', 'r', 's',
    't', 'u', 'v', 'w', 'x', 'y', 'z'
]

type PairObj = object
    value: Base58
    target: string
proc Pair(value: Base58, target: string): PairObj =
    result = PairObj(
        value: value,
        target: target
    )

var
    tempBase58: Base58
    tempDecimal: Decimal
proc test(pair: PairObj): string =
    result = ""

    tempBase58 = pair.value
    if pair.target != $tempBase58:
        result = "Conerted to " & $tempBase58 & "."
        return

    tempDecimal = tempBase58
    if pair.value != tempDecimal:
        result = "Reverted to " & $tempDecimal & "."
        return

proc suite*(): string =
    var pairs: seq[PairObj] = @[
        Pair(newBN(58), "21"),
        Pair(newBN(59), "22"),
        Pair(newBN(131), "3G")
    ]

    for i in 0 ..< Base58Characters.len:
        pairs.add(
            Pair(newBN(i), $Base58Characters[i])
        )

    for pair in pairs:
        result = test(pair)
        if result != "":
            result =
                "Base 58 Test with a value of: " & $pair.value &
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
