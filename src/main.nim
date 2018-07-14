discard """
#Number libs.
import lib/Bases

#SHA512 lib.
import lib/SHA512 as SHA512File

#Block, blockchain, and State libs.
import Merit/Merit

#Wallet libs.
import Wallet/Wallet

#Demo.
var wallet: Wallet = newWallet()
echo wallet.getPublicKey().verify("ffee", wallet.sign("ffee"))
"""

#Number lib.
import lib/Bases

#Time lib.
import lib/time as TimeFile

#Merit lib.
import Merit/Merit

#Wallet lib.
import Wallet/Wallet

var
    #Create a wallet to mine to.
    wallet: Wallet = newWallet()
    #Get the address.
    miner = wallet.getAddress()
    #Merit var.
    merit: Merit = newMerit(newHexadecimal("0"))
    #Block var; defined here to stop a memory leak.
    newBlock: Block
    #Nonce, time, and proof vars.
    nonce: Decimal = newBN(1)
    time: Decimal = getTime()
    proof: Hexadecimal = newBN(0)

echo "First balance: " & $merit.getBalance(miner)

#Mine the chain.
while true:
    echo "Looping..."

    #Create a block.
    newBlock = newBlock(nonce, time, miner, proof)

    #Test it.
    if not merit.testBlock(newBlock):
        #If it's invalid, increase the proof and continue.
        inc(proof)
        continue

    #If it's valid, have the state process it.
    discard merit.processBlock(newBlock)

    #Print that we mined a block!
    echo "Mined a block: " & $nonce
    echo "Balance of the miner is " & $merit.getBalance(miner)

    #Finally, increase the nonce and update the timestamp.
    inc(nonce)
    time = getTime()
