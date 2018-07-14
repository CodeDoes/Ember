import ../BN
export newBN, BNNums

type Decimal* = ref object of RootObj
    value*: BN

proc `+`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value + y.value
    )
proc `+=`*(x: Decimal, y: Decimal) {.raises: [].} =
    x.value += y.value
proc inc*(x: Decimal) {.raises: [].} =
    x.value += BNNums.ONE

proc `-`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value - y.value
    )
proc `-=`*(x: Decimal, y: Decimal) {.raises: [].} =
    x.value -= y.value
proc dec*(x: Decimal) {.raises: [].} =
    x.value -= BNNums.ONE

proc `*`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value * y.value
    )
proc `^`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value ^ y.value
    )
proc `pow`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: (x.value.pow(y.value))
    )

proc `/`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value / y.value
    )
proc `div`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value div y.value
    )

proc `//`*(x: Decimal, y: Decimal): tuple[result: Decimal, remainder: Decimal] {.raises: [].} =
    var temp: tuple[result: BN, remainder: BN] = x.value // y.value
    result = (
        Decimal(
            value: temp.result
        ),
        Decimal(
            value: temp.remainder
        ),
    )
proc divWRemainder*(x: Decimal, y: Decimal): tuple[result: Decimal, remainder: Decimal] {.raises: [].} =
    var temp: tuple[result: BN, remainder: BN] = x.value.divWRemainder(y.value)
    result = (
        Decimal(
            value: temp.result
        ),
        Decimal(
            value: temp.remainder
        ),
    )

proc `%`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value % y.value
    )
proc `mod`*(x: Decimal, y: Decimal): Decimal {.raises: [].} =
    result = Decimal(
        value: x.value mod y.value
    )

proc `==`*(x: Decimal, y: Decimal): bool {.raises: [].} =
    result = x.value == y.value
proc `!=`*(x: Decimal, y: Decimal): bool {.raises: [].} =
    result = x.value != y.value

proc `<`*(x: Decimal, y: Decimal): bool {.raises: [].} =
    result = x.value < y.value
proc `<=`*(x: Decimal, y: Decimal): bool {.raises: [].} =
    result = x.value <= y.value

proc `>`*(x: Decimal, y: Decimal): bool {.raises: [].} =
    result = x.value >= y.value
proc `>=`*(x: Decimal, y: Decimal): bool {.raises: [].} =
    result = x.value >= y.value
