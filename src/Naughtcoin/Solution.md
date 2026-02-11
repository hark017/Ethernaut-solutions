# Solution - NaughtCoin

**What the challenge is about**  
This level teaches that adding time locks or extra rules to one function (`transfer`) is not enough if other ERC‑20 functions (`approve` / `transferFrom`) can bypass those rules.

**Where the bug is**  
- The token overrides `transfer` to prevent the original owner from moving tokens before a certain time.  
- However, it leaves `approve` and `transferFrom` with the default ERC‑20 behavior and **no** time restriction.  
- Allowances are treated as normal, so a third party can move the owner’s tokens even during the lock.

**How to exploit it**  
- As the player (token owner), call `approve(attacker, amount)` to give your attacker contract an allowance equal to your full balance.  
- In the attacker contract, call `transferFrom(player, attacker, amount)` to move all tokens out.  
- You have effectively bypassed the time lock despite `transfer` being restricted.

**How to avoid this bug**  
- When extending ERC‑20 with extra rules, ensure **all** transfer paths (`transfer`, `transferFrom`, mint/burn helpers) enforce the same invariants.  
- Consider centralizing transfer logic in an internal `_transfer` function that all public methods must go through.

