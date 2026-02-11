# Solution - Denial

**What the challenge is about**  
This level highlights how sending ETH to untrusted recipients in a loop (or on every withdraw) can let them lock your contract by consuming all gas.

**Where the bug is**  
- The `Denial` contract forwards a portion of withdrawals to a `partner` by calling it with all remaining gas.  
- There is no gas limit and no protection if the partner’s fallback function is expensive or reverts.  
- A malicious partner can intentionally consume all gas, making every withdrawal revert or run out of gas.

**How to exploit it**  
- Deploy an attacker contract and set it as the `partner`.  
- Implement its fallback/receive function to enter an infinite loop or perform heavy work so it uses all gas.  
- Any attempt to withdraw from `Denial` will now run out of gas when calling the partner, effectively DoS’ing the contract.

**How to avoid this bug**  
- Never send unbounded gas to untrusted contracts; use patterns like `call{gas: X}` with a reasonable stipend.  
- Minimize external calls in critical flows and design withdrawal patterns that cannot be blocked by a misbehaving recipient.

