# Solution - Shop

**What the challenge is about**  
This level teaches how calling an untrusted contract multiple times inside one function can let that contract lie about values (like a price) between calls.

**Where the bug is**  
- The `Shop` contract calls the buyer’s `price()` function twice: once to check a condition and once to set the final price.  
- It assumes the buyer will return a consistent price, but the buyer is an arbitrary contract and can change behavior between calls.

**How to exploit it**  
- Implement a buyer contract that:  
  - On the first `price()` call, returns a value high enough to satisfy the `if (price() >= X)` check.  
  - On the second call (after an internal flag is flipped), returns a much lower price.  
- Call `buy()` from your buyer contract so you get the item while paying the artificially low second price.

**How to avoid this bug**  
- Never rely on untrusted external contracts to provide consistent values within a single transaction.  
- Cache external call results, or better, keep price and business logic entirely inside the trusted contract.

