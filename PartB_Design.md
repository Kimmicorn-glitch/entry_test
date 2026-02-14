# Part B: Design Document

**Section 1: SkillsMarketplace (Agricultural Marketplace)**

**Section 2: SecureLottery (DeFi & NFT Integration)**

---

## WHY I BUILT IT THIS WAY

### 1. Data Structure Choices
**Explain your design decisions for BOTH contracts:**
- When would you choose to use a `mapping` instead of an `array`?
- How did you structure your state variables in `SkillsMarketplace` vs `SecureLottery`?
- What trade-offs did you consider for storage efficiency?

[Write your response here]
 I´d use mapping when I want fast, direct lookups like “is this worker registered?” or “has this address applied already?” It’s clean and cheap for that kind of question. I use an array when I need an ordered list or I need to pick a random entry from a pool.

For SkillsMarketplace, I’d keep workers in a mapping (address -> skill + status) and gigs in an array so each gig gets an ID. Then per‑gig maps help me block duplicates. For SecureLottery, I’d keep an array of entries so multiple entries per person are real, and a mapping to track unique players and their counts.

Storage-wise I’m trying to keep it minimal: arrays grow fast, strings cost more, so I only store what the contract truly needs. Anything else I’d rather emit in events and let the frontend index it.
   

---

### 2. Security Measures
**What attacks did you protect against in BOTH implementations?**
- Reentrancy attacks? (Explain your implementation of the Checks-Effects-Interactions pattern)
- Access control vulnerabilities?
- Integer overflow/underflow?
- Front-running/Randomness manipulation (specifically for `SecureLottery`)?

[Write your response here]

Reentrancy: I make sure the state is updated before sending ETH (Checks‑Effects‑Interactions) and I’d add a simple reentrancy guard if needed.

Access control: owner‑only for admin actions (pause/unpause, select winner) and only the gig poster can approve payments.

Overflow: Solidity ^0.8.x already protects me, but I still validate inputs.

Randomness: I don’t trust just block.timestamp. I mix multiple block values + contract state and enforce time + unique player thresholds. It’s still best effort on chain randomness unless I plug in an oracle (Chainlink VRF)
---

### 3. Trade-offs & Future Improvements
**What would you change with more time?**
- Gas optimization opportunities?
- Additional features (e.g., dispute resolution, multiple prize tiers)?
- Better error handling?

[Write your response here]

---

## REAL-WORLD DEPLOYMENT CONCERNS

### 1. Gas Costs
**Analyze the viability of your contracts for real-world use:**
- Estimated gas for key functions (e.g., `postGig`, `selectWinner`).
- Is this viable for users in constrained environments (e.g., high gas fees)?
- Any specific optimization strategies you implemented?

[Write your response here]

---

### 2. Scalability
**What happens with 10,000+ entries/gigs?**
- Performance considerations for loops or large arrays.
- Storage cost implications.
- Potential bottlenecks in `selectWinner` or `applyForGig`.

[Write your response here]

---

### User Experience

**How would you make this usable for non-crypto users?**
- Onboarding process?
- MetaMask alternatives?
- Mobile accessibility?

[Write about your UX(user experience) considerations]

---

## MY LEARNING APPROACH

### Resources I Used

**Show self-directed learning:**
- Documentation consulted
- Tutorials followed
- Community resources

[List 3-5 resources you used]

---

### Challenges Faced

**Problem-solving evidence:**
- Biggest technical challenge
- How you solved it
- What you learned

[Write down your challenges]

---

### What I'd Learn Next

**Growth mindset indicator:**
- Advanced Solidity patterns
- Testing frameworks
- Frontend integration

[Write your future learning goals]

---
