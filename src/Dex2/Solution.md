# Solution - Dex Two

**What the challenge is about**  
This level extends the first DEX challenge and shows how trusting *any* ERC‑20 as a trading pair can let attackers introduce “fake” tokens to drain reserves.

**Where the bug is**  
- The DEX lets users trade between **any** two tokens, not just the original pair.  
- It still uses the naive `amountOut = amountIn * reserveOut / reserveIn` formula, but now reserves for the malicious token start at zero or very low values.  
- A custom attacker token can be minted arbitrarily, giving the attacker full control of the price.

**How to exploit it**  
- Deploy an attacker ERC‑20 token and approve the DEX to spend it.  
- Seed the DEX with a tiny amount of your token so the reserves are non‑zero.  
- Use your unlimited supply of the attacker token to swap for the real tokens, manipulating the price formula to drain both legitimate reserves.

**How to avoid this bug**  
- Restrict which token pairs a DEX supports and do not let arbitrary tokens become trading pairs without governance/whitelisting.  
- Combine this with robust AMM math and slippage protection so that extremely imbalanced trades are rejected.

