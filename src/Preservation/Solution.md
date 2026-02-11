# Solution - Preservation

**What the challenge is about**  
This level shows how using `delegatecall` to a library with a different storage layout can let attackers overwrite critical variables like `owner`.

**Where the bug is**  
- The contract stores library addresses in the first storage slots and then uses `delegatecall` to them.  
- The library’s functions write to storage slot `0`, but in the main contract that slot holds the first library address, and other important variables (like `owner`) follow.  
- An attacker can swap the library address to their own contract and then use `delegatecall` to write arbitrary values into the main contract’s storage.

**How to exploit it**  
- Deploy an attacker library whose function, when `delegatecall`‑ed, writes `owner = msg.sender`.  
- Call the function that sets the library address so that your malicious contract is now used as the library.  
- Trigger the delegatecall into your library; because it runs in the context of the Preservation contract, it overwrites `owner` with your address.

**How to avoid this bug**  
- Fix and document storage layouts between proxy/library and implementation; never change them independently.  
- Avoid mutable library addresses for critical logic, or restrict who can update them and to what contracts.

