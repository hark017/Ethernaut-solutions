# Solution - Elevator

**What the challenge is about**  
This level illustrates why trusting return values from untrusted contracts (via interfaces) can be dangerous when those values are used for control flow.

**Where the bug is**  
- The `Elevator` calls `Building.isLastFloor(uint256)` on a user‑supplied contract to check if a floor is the last one.  
- It calls `isLastFloor` multiple times and assumes the answer is consistent.  
- An attacker can implement `isLastFloor` to lie on one of the calls and satisfy both checks.

**How to exploit it**  
- Deploy an attacker contract implementing the `Building` interface.  
- Inside `isLastFloor(floor)`, return `false` the first time it is called, and `true` the second time (track a boolean flag).  
- Call `goTo` on the `Elevator` with your attacker as the `Building`. The elevator will believe it reached the last floor and set `top = true`.

**How to avoid this bug**  
- Do not rely on untrusted external contracts to enforce critical conditions.  
- If you must call out, cache return values and consider them hints rather than authoritative security checks.

