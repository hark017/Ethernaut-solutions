# Solution - HigherOrder

**What the challenge is about**  
This level is about low‑level calls and how encoding calldata incorrectly can let users overwrite important storage like a “treasury” value.

**Where the bug is**  
The contract exposes a function that lets anyone call into it with arbitrary calldata. That calldata is decoded into arguments and written into a `treasury`‐related storage slot without proper validation or access control.

**How to exploit it**  
- Craft a transaction with the exact function selector and arguments so that the decoded value written to `treasury` becomes > 255 (or whatever bound the level expects).  
- Once `treasury` is large enough, call `claimLeadership()` to satisfy its check and become the new commander.

**How to avoid this bug**  
- Never expose raw “execute arbitrary calldata” entry points to untrusted users without strict access control.  
- Validate all parameters before writing them into privileged storage and keep invariants enforced at the contract boundary.