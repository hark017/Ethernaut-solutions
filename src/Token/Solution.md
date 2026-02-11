# Solution - Token

**What the challenge is about**  
This level demonstrates arithmetic underflow/overflow in ERC20‑like logic and how it can be abused to create tokens from nothing.

**Where the bug is**  
The `transfer` function subtracts from the sender’s balance **without** proper checks (or in older Solidity versions, without safe math). When you transfer more than your balance, the subtraction underflows and wraps around to a huge number instead of reverting.

**How to exploit it**  
- Start with a small balance.  
- Call `transfer()` with a value slightly **greater** than your balance.  
- The sender’s balance underflows to a very large value, effectively minting tokens for you.

**How to avoid this bug**  
- Use Solidity ^0.8.x (built‑in checked arithmetic) or libraries like OpenZeppelin’s `SafeMath` in older versions.  
- Always validate that balances and allowances are sufficient before modifying them.