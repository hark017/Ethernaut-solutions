# Solution - Switch

**What the challenge is about**  
This level teaches about function selectors, low‑level calls, and how carefully crafted calldata can bypass naive “switch” style logic.

**Where the bug is**  
The contract uses a hand‑rolled switch / dispatch mechanism that checks the first 4 bytes of calldata (the function selector) and some additional conditions, but it does not fully constrain what the rest of the calldata can do. With the right layout, you can make storage writes happen in an unintended way.

**How to exploit it**  
- Study the `Switch` ABI and how it reads and writes from calldata into storage.  
- Construct calldata where the selector and arguments satisfy the outer checks, but the inner logic ends up writing `true` to the `switchOn` flag (or similar) even though the intended path should not allow it.  
- Send a raw transaction with that calldata to flip the switch.

**How to avoid this bug**  
- Avoid ad‑hoc dispatcher implementations; rely on Solidity’s normal function dispatch and access control.  
- If you must parse calldata manually, carefully validate lengths, offsets and invariants, and use tests/fuzzing to catch strange edge cases.

