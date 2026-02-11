# Solution - Fallback

**What the challenge is about**  
This level shows how mis‑designed fallback / receive functions, combined with poor accounting, can leak ownership and funds.

**Where the bug is**  
- The contract lets anyone become a “contributor” by sending a tiny amount of ETH.  
- The `receive()`/fallback function updates `contributions[msg.sender]` and then, if `contributions[msg.sender] > contributions[owner]`, it sets `owner = msg.sender`.  
- The `withdraw()` function is restricted only by `owner`.

**How to exploit it**  
- Call the contribution function once so you are in the `contributions` mapping.  
- Send a small amount of ETH directly to the contract (triggering the fallback) with a value that makes your contribution higher than the current owner’s.  
- You become `owner` and can then call `withdraw()` to drain the contract.

**How to avoid this bug**  
- Never tie ownership or critical roles to mutable accounting variables like contributions or balances.  
- Keep access control logic separate, explicit, and protected (e.g. using Ownable/AccessControl).