# Solution - GatekeeperTwo

**What the challenge is about**  
This level demonstrates how `extcodesize`, constructor behavior, and bit‑twiddling on keys can all be combined into tricky access gates.

**Where the bug is**  
- One gate checks that `extcodesize(msg.sender) == 0`, which is only true **during a contract’s constructor**, not after deployment.  
- Another gate requires a specific relationship between a provided key and `keccak256(msg.sender)`, but that key can be computed off‑chain or inside the attacking constructor.

**How to exploit it**  
- Write an attacker contract whose constructor calls `GatekeeperTwo.enter(key)`.  
- Inside the constructor, compute the required key using the same operations as the gate (e.g. some inverse or XOR of `keccak256(address(this))`).  
- Because `extcodesize(address(this))` is 0 in the constructor, and the key is correct, you pass all gates and become the entrant.

**How to avoid this bug**  
- Do not rely on `extcodesize` for authentication; it is fragile and can often be bypassed using constructors or proxies.  
- Keep gate conditions simple and avoid over‑complicated bit constraints that can be reverse‑engineered.

