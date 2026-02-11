# Solution - King

**What the challenge is about**  
This level shows how contracts that expect recipients to always accept ETH can be permanently DoS’d by a contract that refuses payments.

**Where the bug is**  
- The `King` contract sends ETH to the previous king using a low‑level call (`transfer`/`call`) whenever someone becomes the new king.  
- It does not handle the case where that payment fails; instead, the whole transaction reverts.  
- If a contract with a reverting fallback becomes king, nobody else can dethrone it, because every future attempt to pay it will fail.

**How to exploit it**  
- Deploy an attacker contract with a fallback/receive function that always reverts when it receives ETH.  
- Call the `King` contract with more ETH than the current prize so your contract becomes the new king.  
- Now any attempt by others to become king will revert when the contract tries to pay you, locking the game.

**How to avoid this bug**  
- Avoid pushing ETH to arbitrary recipients as part of critical state transitions; use pull‑payment patterns instead.  
- When you must send ETH, consider not reverting if the send fails, or allow the recipient to claim funds separately.

