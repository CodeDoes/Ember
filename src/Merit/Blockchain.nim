#Number libs.
import ../lib/Bases

#Time lib.
import ../lib/time

#Block and Difficulty libs.
import Block as BlockFile
import Difficulty as DifficultyFile

#Lists standard lib.
import lists

#Blockchain object.
type Blockchain* = ref object of RootObj
    #Genesis string or network ID.
    genesis: Hexadecimal
    #Blockchain height. BN for compatibility.
    height: Decimal
    #Doubly Linked List of all the blocks, and another of all the difficulties.
    blocks: DoublyLinkedList[Block]
    difficulties: DoublyLinkedList[Difficulty]

#Create a new Blockchain.
proc newBlockchain*(genesis: Hexadecimal): Blockchain {.raises: [ValueError, OverflowError, AssertionError].} =
    #Set the current time as the time of creation.
    let creation: Decimal = getTime()

    #Init the object.
    result = Blockchain(
        genesis: genesis,
        height: newBN(0),
        blocks: initDoublyLinkedList[Block](),
        difficulties: initDoublyLinkedList[Difficulty]()
    )

    #Append the starting difficulty.
    result.difficulties.append(Difficulty(
        start: creation,
        endTime: creation + newBN("60"),
        difficulty: Hexadecimal(
            value: "3333333333333333333333333333333333333333333333333333333333333333"
        )
    ))
    #Append the genesis block. ID 0, creation time, mined to a 0'd public key, with a proof that doesn't matter of "0".
    result.blocks.append(newBlock(newBN(0), creation, "Emb111111111111111111111111111111111111111111111111111111111111", newHexadecimal("0")))

#Tests a block for validity.
proc testBlock*(blockchain: Blockchain, newBlock: Block): bool {.raises: [OverflowError, AssertionError, Exception].} =
    #Result is set to true in case if nothing goes wrong.
    result = true

    #If the nonce is off...
    if blockchain.height + BNNums.ONE != newBlock.getNonce():
        result = false
        return

    #If the time is before the last block's...
    if blockchain.blocks.tail.value.getTime() >= newBlock.getTime():
        result = false
        return

    #If the time is ahead of 20 minutes from now...
    if (getTime() + newBN($(20*60))) < newBlock.getTime():
        result = false
        return

    #If the block is invalid...
    if not newBlock.verifyBlock():
        result = false
        return

    #Generate difficulties so we can test the block against the latest difficulty.
    while blockchain.difficulties.tail.value.endTime < newBlock.getTime():
        blockchain.difficulties.append(calculateNextDifficulty(blockchain.blocks, blockchain.difficulties, (60), 6))

    #If the difficulty wasn't beat...
    if not blockchain.difficulties.tail.value.verifyDifficulty(newBlock):
        result = false
        return

#Adds a block to the blockchain.
proc addBlock*(blockchain: Blockchain, newBlock: Block): bool {.raises: [OverflowError, AssertionError, Exception].} =
    #Test the block.
    if not blockchain.testBlock(newBlock):
        result = false
        return

    #If we're still here, increase the height, append the new block, and return true.
    inc(blockchain.height)
    blockchain.blocks.append(newBlock)
    result = true

#Getters for the genesis string, height, blocks, and difficulties (along with iterators).
proc getGenesis*(blockchain: Blockchain): Hexadecimal {.raises: [].} =
    result = blockchain.genesis

proc getHeight*(blockchain: Blockchain): Decimal {.raises: [].} =
    result = blockchain.height

proc getBlocks*(blockchain: Blockchain): DoublyLinkedList[Block] {.raises: [].} =
    result = blockchain.blocks

iterator getBlocks*(blockchain: Blockchain): Block {.raises: [].} =
    for i in blockchain.blocks.items():
        yield i

proc getDifficulties*(blockchain: Blockchain): DoublyLinkedList[Difficulty] {.raises: [].} =
    result = blockchain.difficulties

iterator getDifficulties*(blockchain: Blockchain): Difficulty {.raises: [].} =
    for i in blockchain.difficulties.items():
        yield i
