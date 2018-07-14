import ../lib/Bases

import Block
import Blockchain

import tables

type State* = ref Table[string, Decimal]

proc newState*(): State {.raises: [].} =
    result = new State
    result[] = initTable[string, Decimal]()

proc getBalance*(state: State, account: string): Decimal {.raises: [KeyError].} =
    result = newBN(0)
    if state.hasKey(account):
        result = state[account]

proc processBlock*(state: State, newBlock: Block) {.raises: [KeyError].} =
    state[newBlock.getMiner()] = state.getBalance(newBlock.getMiner()) + newBN(100)

proc processBlockchain*(state: State, blockchain: Blockchain) {.raises: [KeyError].} =
    state[] = initTable[string, Decimal]()
    for i in blockchain.getBlocks():
        state.processBlock(i)

proc newState*(blockchain: Blockchain): State {.raises: [KeyError].} =
    result = new State
    result[] = initTable[string, Decimal]()
    result.processBlockchain(blockchain)
