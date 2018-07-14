import Decimal as DecimalFile
import Hexadecimal as HexadecimalFile
import Base58 as Base58File
import Logic

import ../BN as BNFile

converter toDecimal*(x: BN): Decimal =
    result = Decimal()
    result.value = x
converter toDecimal*(x: Hexadecimal): Decimal =
    result = revert[Hexadecimal](HexadecimalData, x)
converter toDecimal*(x: Base58): Decimal =
    result = revert[Base58](Base58Data, x)

converter toHexadecimal*(x: BN): Hexadecimal =
    result = convert[Hexadecimal](HexadecimalData, x)
converter toHexadecimal*(x: Decimal): Hexadecimal =
    result = convert[Hexadecimal](HexadecimalData, x)
converter toHexadecimal*(x: Base58): Hexadecimal =
    result = convert[Hexadecimal](HexadecimalData, revert[Base58](Base58Data, x))

converter toBase58*(x: BN): Base58 =
    result = convert[Base58](Base58Data, x)
converter toBase58*(x: Decimal): Base58 =
    result = convert[Base58](Base58Data, x)
converter toBase58*(x: Hexadecimal): Base58 =
    result = convert[Base58](Base58Data, revert[Hexadecimal](HexadecimalData, x))

proc `$`*(x: Decimal): string =
    return $x.value
proc `$`*(x: Hexadecimal): string =
    return $x.value
proc `$`*(x: Base58): string =
    return $x.value
