# Solution - Delegate

**What the challenge is about**  
This level teaches how `delegatecall` reuses another contract’s code but **your** contract’s storage, which can accidentally expose critical state.

**Where the bug is**  
The contract allows an external call that performs a `delegatecall` into an untrusted `Delegate` contract. Inside `Delegate`, the `pwn()` function writes to storage slot `0`, which in the calling contract is the `owner` variable.

**How to exploit it**  
- Call the entry function that does `delegatecall` and set the calldata to `pwn()`’s function selector.  
- Because of `delegatecall`, `pwn()` runs in the context of the target contract and sets `owner = msg.sender`, making you the owner.

**How to avoid this bug**  
- Never `delegatecall` to contracts you do not fully control and audit.  
- Fix the storage layout between proxy and implementation, and restrict which functions can be called via `delegatecall`.