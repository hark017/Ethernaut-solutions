# Solution - Fallout

**What the challenge is about**  
This level demonstrates how a misspelled constructor in older Solidity versions (pre‑0.4.22) becomes a **public function** that anyone can call.

**Where the bug is**  
The intended constructor is named `Fal1out` (with a `1`) instead of matching the contract name exactly. In those compiler versions, that means `Fal1out()` is just a normal public function that sets `owner = msg.sender`.

**How to exploit it**  
- Simply call `Fal1out()` as the player.  
- The function runs and sets `owner` to your address because it was never restricted to deployment time.

**How to avoid this bug**  
- Use modern Solidity with the `constructor` keyword so this class of bug is impossible.  
- When reviewing legacy code, double‑check that any function that *looks* like a constructor is not publicly callable.