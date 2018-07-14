#Wrapper for the Lyra2 C library made by the people behind Lyra2.

#Number lib.
import Bases

#C function.
proc cCalcLyra2(data: cstring, salt: cstring): cstring {.header: "../../src/lib/Lyra2/wrapper.h", importc: "calcLyra2".}
#Take in data and a salt, return a 64 character string.
proc Lyra2*(dataArg: Hexadecimal, saltArg: Hexadecimal): Hexadecimal {.raises: [ValueError].} =
    var
        data: string = $dataArg
        salt: string = $saltArg
    result = newHexadecimal($cCalcLyra2(addr data[0], addr salt[0]))
