# Solution - Recovery

**What the challenge is about**  
This level is about how contract addresses are deterministically derived from a creator address and nonce, and how you can “recover” lost contracts and funds by reconstructing those addresses.

**Where the bug is**  
- A `Recovery`‑style contract deploys another contract that holds ETH, but then forgets or loses the address.  
- The “lost” contract still has a payable `selfdestruct` or withdrawal function that anyone can call once they find the address.

**How to exploit it**  
- Reconstruct the lost contract’s address from `keccak256(rlp.encode([creatorAddress, nonce]))` (or use tools to compute it).  
- Once you have the address, inspect its bytecode and identify its `destroy`/`withdraw` function.  
- Call that function to `selfdestruct` the lost contract, sending the remaining ETH to your address.

**How to avoid this bug**  
- Keep good bookkeeping for deployed contract addresses and avoid “orphan” contracts with funds.  
- Be cautious with contracts that can `selfdestruct` to arbitrary recipients; any holder of the address can usually trigger it.

