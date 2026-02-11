# Solution - Telephone

**What the challenge is about**  
This level shows why using `tx.origin` for authorization is dangerous and how it can be abused through intermediate contracts.

**Where the bug is**  
The contract checks `require(tx.origin == owner)` (or similar) to guard `changeOwner`, instead of using `msg.sender`. This means any contract can forward a call where `tx.origin` is still the original EOA.

**How to exploit it**  
- Deploy an attacker contract with a function that calls `Telephone.changeOwner(player)`.  
- As the player EOA, call the attacker contract.  
- Inside `Telephone`, `tx.origin` is the player and passes the check, but `msg.sender` is the attacker contract, which can set the owner to you.

**How to avoid this bug**  
- Never use `tx.origin` for permission checks; always rely on `msg.sender`.  
- Treat `tx.origin` only as a debugging/observability tool, not for access control.