#Wallet lib.
import Wallet/Wallet

#Declare the Wallet/Address vars here to not memory leak.
var
    wallet: Wallet
    address: string

#Run 500 times.
for _ in 0 ..< 500:
    #Create a new wallet.
    wallet = newWallet()
    #Get the address.
    address = wallet.getAddress()

    #Verify the address.
    if address.verify() == false:
        raise newException(Exception, "Invalid Address Type 1")
    #Verify the address for the matching pub key.
    if address.verify(wallet.getPublicKey()) == false:
        raise newException(Exception, "Invalid Address Type 2")

    #Print the generated address.
    echo address
