# Solution - Privacy

**What the challenge is about**  
This level shows that marking data as `private` in Solidity does **not** hide it from the blockchain; all storage is publicly readable.

**Where the bug is**  
The contract stores a supposed “secret” in a `bytes32[3] data` array and then uses the last element to protect `unlock()`. Although the variable is `private`, anyone can read that storage slot.

**How to exploit it**  
- Use `eth_getStorageAt` (or `web3.eth.getStorageAt`) to read the storage slot where `data[2]` lives.  
- Take the first 16 bytes of that `bytes32` value and pass them to `unlock(bytes16)`.  
- The contract validates against that same value, so you can unlock it.

**How to avoid this bug**  
- Never treat on‑chain storage (even `private`) as a secret; everything is visible.  
- If you need secrecy, keep secrets off‑chain or use proper cryptography with public commitments only.