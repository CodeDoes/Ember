#Wrapper around the Nim time library that returns a Decimal.

#Import number libs.
import Bases

#Standard libs for time/string manipulation.
import times, strutils

#Function that returns the time.
proc getTime*(): Decimal {.raises: [AssertionError].} =
    #Get the time, split off any decimal, and convert to a Decimal.
    result = newBN(($(epochTime())).split(".")[0])
