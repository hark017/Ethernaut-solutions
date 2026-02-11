# Solution - Force

**What the challenge is about**  
This level demonstrates that a contract **cannot refuse** to receive ETH; other contracts can forcibly send ETH using `selfdestruct`.

**Where the bug is**  
- The target contract assumes its ETH balance will always be zero because it has no payable functions and never receives ETH via normal calls.  
- However, anyone can create another contract, fund it, and then `selfdestruct` to the target address, which unconditionally transfers its balance there.

**How to exploit it**  
- Deploy a simple attacker contract with a payable constructor.  
- Fund the attacker contract with some ETH.  
- Call a function on it that executes `selfdestruct(target)`.  
- The target contract’s balance increases, satisfying the level’s condition even though it had no payable functions.

**How to avoid this bug**  
- Do not rely on `address(this).balance` being zero unless you explicitly account for forced ETH.  
- Design invariants and logic to tolerate unexpected balance changes or use patterns that don’t depend directly on raw ETH balances.

