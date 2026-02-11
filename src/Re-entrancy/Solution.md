# Solution - Reentrancy

**What the challenge is about**  
This classic level teaches reentrancy vulnerabilities, where an external contract can call back into a function before state is fully updated.

**Where the bug is**  
- The `withdraw` / `donate` logic sends ETH to the caller using a low‑level `call` **before** updating the sender’s recorded balance.  
- This lets an attacker re‑enter `withdraw` from their fallback function while the old balance is still in place, draining the contract.

**How to exploit it**  
- Deploy an attacker contract that donates some ETH to the target so it has a positive balance recorded.  
- In the attacker’s fallback/receive function, call `withdraw()` again whenever ETH is received, as long as the recorded balance is > 0.  
- Each reentrant call withdraws more funds before the balance is finally reduced, emptying the contract.

**How to avoid this bug**  
- Follow the checks‑effects‑interactions pattern: update balances **before** sending ETH.  
- Alternatively, use a reentrancy guard (`nonReentrant`) or pull‑payments, where users explicitly withdraw their own funds.

