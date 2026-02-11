# Solution - AlienCodex

**What the challenge is about**  
This level is about how dynamic arrays are laid out in storage and how an integer underflow can let you overwrite arbitrary storage slots, including `owner`.

**Where the bug is**  
The `retract()` function decreases the length of `codex` without safety checks. When the length is already `0`, subtracting `1` underflows and sets the array length to \(2^{256} - 1\), so the array “covers” the entire storage.

**How to exploit it (high level)**  
- Call `makeContact()` so the contract accepts interaction.  
- Call `retract()` once to underflow the array length to \(2^{256} - 1\).  
- Compute the index `i` such that `keccak256(abi.encode(1)) + i == 0` (the slot where `owner` is stored).  
- Call `revise(i, bytes32(uint256(uint160(player))))` to overwrite the `owner` slot with your address.

**How to avoid this bug**  
- Always use checked arithmetic (or Solidity ^0.8.0 built‑in checks) when changing array lengths.  
- Never allow user‑controlled indices to indirectly write to critical storage like `owner` unless tightly validated.