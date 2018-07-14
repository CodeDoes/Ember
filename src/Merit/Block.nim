#Number libs.
import ../lib/Bases

#Import the time library.
import ../lib/time

#Import the hashing libraries.
import ../lib/SHA512
import ../lib/Lyra2

#Import the Address library.
import ../Wallet/Address

#Define the Block class.
type Block* = ref object of RootObj
    #Nonce, AKA index.
    nonce: Decimal
    #Timestamp.
    time: Decimal
    #Who to attribute the Rep to.
    miner: string
    #Block's SHA512 hash.
    hash: Hexadecimal
    #Random hex number to make sure the Lyra of the hash is over the difficulty.
    proof: Hexadecimal
    #Lyra2 64 character hash with the hash as the data and proof as the salt.
    lyra: Hexadecimal

#New Block function. Makes a new block. Raises an error if there's an issue.
proc newBlock*(nonce: Decimal, time: Decimal, miner: string, proof: Hexadecimal): Block {.raises: [ValueError, OverflowError].} =
    #Verify the arguments.
    if Address.verify(miner) == false:
        raise newException(ValueError, "Invalid Address.")

    #Ceate the block.
    result = Block(
        nonce: nonce,
        time: time,
        miner: miner,
        proof: proof
    )

    #Create the hash.
    result.hash = newHexadecimal(
        ($SHA512(nonce)).substr(0, 31) &
        ($SHA512(time)).substr(32, 63) &
        ($SHA512(newBase58(miner.substr(3, miner.len)))).substr(64, 127)
    )

    #Calculate the Lyra hash.
    result.lyra = Lyra2(result.hash, result.proof)

#Verify Block function. Creates the block with the passed in arguments and verifies the hashes. Doesn't check its Blockchain validity.
proc verifyBlock*(newBlock: Block): bool {.raises: [ValueError, OverflowError].} =
    result = true

    let createdBlock: Block = newBlock(newBlock.nonce, newBlock.time, newBlock.miner, newBlock.proof)
    if toDecimal(createdBlock.hash) != toDecimal(newBlock.hash):
        result = false
        return

    if createdBlock.lyra != newBlock.lyra:
        result = false
        return

#Getters.
proc getNonce*(blockArg: Block): Decimal {.raises: [].} =
    return blockArg.nonce

proc getTime*(blockArg: Block): Decimal {.raises: [].} =
    return blockArg.time

proc getMiner*(blockArg: Block): string {.raises: [].} =
    return blockArg.miner

proc getHash*(blockArg: Block): Hexadecimal {.raises: [].} =
    return blockArg.hash

proc getProof*(blockArg: Block): Hexadecimal {.raises: [].} =
    return blockArg.proof

proc getLyra*(blockArg: Block): Hexadecimal {.raises: [].} =
    return blockArg.lyra
