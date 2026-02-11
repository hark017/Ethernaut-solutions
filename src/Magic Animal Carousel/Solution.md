# Solution - Magic Animal Carousel

**What the challenge is about**  
This level is about tightly packed storage, bitwise operations, and how off‑by‑one/length mistakes let you corrupt adjacent fields (like the “next crate” pointer).

**Where the bug is**  
- Each carousel slot stores: `animal` (80 bits), `nextCrateId` (16 bits) and `owner` (160 bits) in a single `uint256`.  
- `encodeAnimalName` allows names up to 12 bytes, but only 10 bytes are reserved for the animal field.  
- `changeAnimal` writes the full encoded name without the right shifting used in `setAnimalAndSpin`, so 12‑byte names overflow into the `nextCrateId` bits.

**How to exploit it**  
- First, call `setAnimalAndSpin("Dog")` to initialize crate `1` and set its `nextCrateId` normally.  
- Then call `changeAnimal()` on crate `1` with a crafted 12‑byte string whose last two bytes are `0xFFFF`, so `nextCrateId` becomes `65535`.  
- Next, call `setAnimalAndSpin("Parrot")`; the carousel now writes to crate `65535` and links it back to crate `1`, leaving the carousel in an inconsistent state that breaks the “magic rule”.

**How to avoid this bug**  
- When packing multiple values into a single word, keep the bit layout and maximum sizes in strict sync with all encoding/decoding functions.  
- Prefer simple, explicit structs over manual bit‑twiddling unless you have a very strong reason and thorough tests.

