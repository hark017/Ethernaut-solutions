# Solution - Stake

**What the challenge is about**  
This level focuses on unsafe external calls to ERC‑20 tokens and how trusting an arbitrary “WETH” contract can break accounting invariants.

**Where the bug is**  
- The contract interacts with `WETH` via raw `call`, decoding the allowance from arbitrary bytes and not checking return values strictly.  
- It increases `totalStaked` and `UserStake[msg.sender]` **before** verifying that tokens were really transferred.  
- A malicious ERC‑20 implementation can lie about allowances or transfers so that staking logic believes funds were moved when they were not.

**How to exploit it**  
- Deploy a malicious token that always returns a huge allowance and reports successful transfers without actually moving real value.  
- Call `StakeWETH` with that token to inflate `totalStaked` and your `UserStake` while leaving the contract’s ETH balance unchanged.  
- Use `Unstake` and the level’s conditions to reach a state where `totalStaked` is greater than the contract balance while your own recorded stake is zero.

**How to avoid this bug**  
- Use well‑audited token interfaces (e.g. OpenZeppelin’s `IERC20`) and check both return values and balances.  
- Never trust external contracts for your internal accounting; validate that balances changed as expected before updating critical totals.

