# Solution - Good Samaritan

**What the challenge is about**  
This level is about error handling with `try/catch` and custom errors, and how attacker contracts can control which error is thrown to influence control flow.

**Where the bug is**  
- `GoodSamaritan.requestDonation()` calls `wallet.donate10(msg.sender)` inside a `try`.  
- If it catches an error whose signature matches `NotEnoughBalance()`, it calls `wallet.transferRemainder(msg.sender)`, sending **all** remaining coins.  
- The wallet uses a `Coin` contract that calls `INotifyable(dest).notify(amount)` on contracts; an attacker can revert from `notify` with a crafted error.

**How to exploit it**  
- Deploy an attacker contract that implements `notify(uint256)` and, when called with `amount == 10`, reverts with the encoded `NotEnoughBalance()` error.  
- Call `requestDonation()` from that attacker contract.  
- The revert bubbles up, gets caught as `NotEnoughBalance()`, and `transferRemainder` is executed, draining the wallet’s entire Coin balance to the attacker.

**How to avoid this bug**  
- Do not dispatch critical logic based solely on matching error signatures from untrusted contracts.  
- Keep error‑driven control flow simple, and avoid `try/catch` patterns that can be intentionally triggered by users for privileged actions.

