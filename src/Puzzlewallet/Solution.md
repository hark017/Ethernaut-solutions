# Solution - PuzzleWallet

**What the challenge is about**  
This level combines upgradeable proxy patterns, storage layout collisions, and a `multicall`/`deposit` accounting bug.

**Where the bug is**  
- The proxy and implementation contracts share storage slots; `owner`/`admin` and `maxBalance` overlap, so writing one can corrupt the other.  
- The `initialize`/`setMaxBalance` logic is not properly restricted, allowing an attacker to take over if it has not been called yet or if they can become owner.  
- The `multicall` function lets you nest `deposit` calls, but the contract only charges `msg.value` once, letting you increase your recorded balance multiple times for a single ETH transfer.

**How to exploit it**  
- Call `proposeNewAdmin` / `addToWhitelist` or similar steps (depending on implementation) to get yourself whitelisted.  
- Use `multicall` with nested `deposit` calls so that your balance is increased multiple times while sending ETH only once.  
- Use the inflated balance to drain the contract via `execute`.  
- Finally, leverage the storage collision (e.g. via `setMaxBalance`) to overwrite the proxy admin/owner slot and gain permanent control.

**How to avoid this bug**  
- Carefully align and document storage layouts between proxies and implementations; never reuse critical slots for different variables.  
- Treat `multicall`/batching functions as high‑risk: ensure accounting (like `msg.value`) is applied per logical deposit, not per outer call.

