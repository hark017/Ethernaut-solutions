# Solution - Vault

**What the challenge is about**  
This level reinforces that `private` variables are not actually secret on-chain; anyone can inspect contract storage.

**Where the bug is**  
The contract stores a `bytes32 password` in storage slot 1 and uses it to guard `unlock()`, assuming it cannot be seen because it is `private`.

**How to exploit it**  
- Use `eth_getStorageAt(contract.address, 1)` to read the raw 32‑byte password value from storage.  
- Call `unlock(password)` with that exact value to open the vault.

**How to avoid this bug**  
- Do not store secrets (passwords, private keys, etc.) directly on-chain.  
- Design systems so that anything written to storage can safely be considered public information.