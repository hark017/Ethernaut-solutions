# Solution - GatekeeperThree

**What the challenge is about**  
This level combines multiple gates: ownership checks, a tricky helper contract (`SimpleTrick`), and a payment condition that depends on whether a `send` call fails.

**Where the bug is**  
- The contract has a public function `construct0r()` that anyone can call to become `owner` (it is **not** a real constructor).  
- `gateTwo` depends on `allowEntrance`, which is set via `getAllowance()` only when `SimpleTrick.checkPassword` returns `true`.  
- `gateThree` requires that sending `0.001 ether` to `owner` **fails** (`send` returns `false`) while the contract has more than that in its balance.

**How to exploit it**  
- Call `construct0r()` through an attacker contract so you become `owner` while still satisfying `tx.origin != owner`.  
- Call `createTrick()` and then use the `SimpleTrick` instance to determine or reuse the `password` so that `getAllowance(password)` sets `allowEntrance = true`.  
- Fund the gatekeeper with a bit more than `0.001 ether`, then make `send(0.001 ether)` to the owner fail (e.g. have the owner be a contract whose fallback reverts).  
- Finally, call `enter()` through your attacker contract to pass all three gates and set yourself as `entrant`.

**How to avoid this bug**  
- Use the `constructor` keyword for constructors and never expose them as public functions.  
- Be very cautious about complex multi‑gate logic; each gate should be simple, explicit, and not depend on fragile behaviors like `send` failures.

