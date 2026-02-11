# Solution - CoinFlip

**What the challenge is about**  
This level shows why deriving “randomness” directly from predictable chain data like `blockhash` and `block.number` is insecure.

**Where the bug is**  
- The contract computes the coin flip outcome from `uint256(blockhash(block.number - 1))` and a known constant.  
- This value is completely deterministic and can be recomputed off‑chain or inside an attacker contract in the same block.

**How to exploit it**  
- Write an attacker contract that calls the same coin‑flip calculation as the target contract to predict the next outcome.  
- Call `flip(predictedSide)` each block from your attacker, always passing the correct guess.  
- Repeat until you reach the required streak of consecutive wins.

**How to avoid this bug**  
- Do not use block hashes, timestamps, or block numbers alone for randomness if miners or users can influence them.  
- Use a proper randomness source (e.g. VRF or commit‑reveal schemes) and assume miners can see and influence pending transactions.

