# Solution - Dex

**What the challenge is about**  
This level shows how naive on‑chain “automated market maker” pricing can be manipulated when the pool is very small.

**Where the bug is**  
- The DEX calculates swap prices using a simple `amountOut = amountIn * reserveOut / reserveIn` formula with **no slippage protection** and no minimum output checks.  
- Users can trade back and forth in a thin pool, pushing the price arbitrarily and draining one side of the pair.

**How to exploit it**  
- Repeatedly swap all of token A for token B, then all of token B back to token A, taking advantage of the skewed pool after each trade.  
- Because the calculation is symmetric but the pool gets more imbalanced each time, you end up draining one token from the DEX.

**How to avoid this bug**  
- Never use a simplistic price formula without slippage limits and minimum out parameters.  
- Use well‑tested AMM designs (e.g. Uniswap‑style with proper invariants and checks) instead of rolling your own.

