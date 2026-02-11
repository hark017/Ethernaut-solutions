# Solution - GatekeeperOne

**What the challenge is about**  
This level combines three different “gates”: requiring a contract caller, a precise gas value, and a carefully constructed 8‑byte key derived from the caller’s address.

**Where the bug is**  
- `gateOne` enforces `msg.sender != tx.origin`, so the call must come from a contract.  
- `gateTwo` requires `gasleft() % 8191 == 0`, which can be satisfied by brute‑forcing or tuning the gas sent from the attacker contract.  
- `gateThree` checks bit conditions on a `bytes8 _gateKey` vs `uint64(uint160(tx.origin))`, but the relationship is reversible, so the correct key can be computed.

**How to exploit it**  
- Deploy an attacker contract with a function that loops over different gas offsets when calling `enter()`, until `gasleft() % 8191 == 0` inside the gate.  
- Compute a valid `_gateKey` from `tx.origin` by following the same bit operations used in the contract.  
- Once both gas and key line up, the call passes all gates and sets you as the entrant.

**How to avoid this bug**  
- Avoid using fragile properties like exact gas values for security; they can usually be brute‑forced.  
- Keep access control simple, explicit, and based on roles/permissions rather than puzzles involving `tx.origin`, gas, or bit tricks.

