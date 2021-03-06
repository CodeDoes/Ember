# TODO

Core:
- Lattice.
- UI.
- DB.
- Network.
- Write tests for:
    - BN
    - SECP256K1Wrapper
    - SHA512

    - Block
    - Difficulty

    - Address

Features:
- Add Merit decay.
- Threaded mining.
- Dedicated miner.

Bug fixes and behavior changes:
- Smooth difficulty scaling (difficulty may also only be rescaling on block mining; this is inefficient).
- Optimize SECP256K1Wrapper (memory copies, splices...).
- Multiple uses of the generic `Exception`.
- Make each Base a type and add converters.

Documentation:
- Add comments to:
    - lib/Base58.nim
    - lib/Hex.nim

    - Merit/State.nim

    - Wallet/PublicKey.nim
    - Wallet/Wallet.nim

    - Lattice/
    - UI/
    - DB/
    - Network/

    - tests/
- Use Documentation Comments.
- Merit Caching Whitepaper.

Community Service:
- Create a Nimble library out of Base58/Hex.
- Create a Nimble library out of Lyra2.
- Create a Nimble file for Ember.
