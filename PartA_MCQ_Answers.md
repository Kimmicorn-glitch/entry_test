# Part A: MCQ Answers

**Status:** In Progress  

---

## Instructions
**COMPLETE ALL QUESTIONS FOR BOTH PART 1 AND PART 2 BELOW**

---

## PART 1: Agricultural Marketplace (Real-World African Context)

**Scenario:** You are hired as a blockchain developer to build a decentralised agricultural marketplace for African farmers. The platform must:

- Allow farmers to list produce as NFTs with quality certificates  
- Enable buyers to swap tokens for produce using a DEX  
- Store farmer reputation scores transparently  
- Process payments without intermediaries  

---

### Question 1: Architecture Decision (Technical Reasoning)

**Which combination of technologies demonstrates the best understanding of blockchain fundamentals for this use case?**

- **A)** Use ERC-721 for each produce item, build a centralised database for reputation, and integrate Binance for payments because CEXs have better liquidity.  
- **B)** Use ERC-1155 for produce items (enabling batch listings from farmers), implement reputation as on-chain mappings in the marketplace smart contract, and integrate with a DEX like Uniswap for direct farmer-to-buyer swaps to minimise intermediaries.  
- **C)** Use ERC-721 exclusively, store all data off-chain for gas savings, and require buyers to use MetaMask with manual price negotiations.  
- **D)** Build everything as separate NFT collections with no DEX integration since farmers won't understand DeFi protocols.  

**Your Answer:** B  

**Your Reasoning:**  
I’m still learning, but B feels right because it keeps things on‑chain and simple. ERC‑1155 lets farmers list a bunch of similar items at once (cheaper and easier), and reputation stays visible and not controlled by a middleman. Using a DEX means farmers can get paid directly without a central company holding funds.  

---

### Question 2: Cost Optimisation (Practical Aptitude)

A farmer wants to list 50 bags of maize. Gas costs are:

- **ERC-721:** 100,000 gas per NFT mint  
- **ERC-1155:** 150,000 gas for first mint + 5,000 gas per additional item in batch  

**Current gas price:** 20 gwei  
**1 ETH = $3,000**

**What is the gas cost difference between ERC-721 and ERC-1155 for listing 50 items?**

- **A)** ERC-721 is cheaper by $15  
- **B)** ERC-1155 is cheaper by approximately $27  
- **C)** They cost exactly the same  
- **D)** ERC-1155 is cheaper by approximately $54  

**Your Answer:** D (closest option, my math gives about $276 cheaper)  

**Your Calculation/Reasoning:**  
- ERC-721 cost = 50 × 100,000 = 5,000,000 gas  
  5,000,000 × 20 gwei = 100,000,000 gwei = 0.1 ETH = $300  
- ERC-1155 cost = 150,000 + (49 × 5,000) = 395,000 gas  
  395,000 × 20 gwei = 7,900,000 gwei = 0.0079 ETH = $23.70  
- Difference = 0.1 − 0.0079 = 0.0921 ETH = $276.30  


Gas optimisation matters because a lot of users can’t afford high fees. If fees are too high, people just won’t use it. Cheaper transactions help farmers list more without losing money to gas.  

---

### Question 3: Value Proposition Explanation (Communication & Thinking)

A farmer asks: *"Why can't we just use a normal website with a database?"*

**Which response demonstrates understanding of blockchain's actual value (not just its technology)?**

- **A)** "Blockchain is the future; everyone should use it."  
- **B)** "With blockchain, no middleman can manipulate your pricing or payment records. If a buyer claims they paid but you didn't receive funds, the blockchain provides immutable proof. Plus, your reputation score can follow you to other platforms since it's on-chain – it's your data, not the platform's."  
- **C)** "Because smart contracts are more secure than databases and Web3 is decentralised."  
- **D)** "Blockchain uses cryptography which makes it unhackable, unlike normal databases."  

**Your Answer:** B  

**Your Explanation:**  
B is the only one that explains real benefits, not just “blockchain is cool.” It says no middleman can mess with payments, and reputation belongs to the farmer. In places where trust is hard and disputes are common, that’s actually useful.  

---

## PART 2: DeFi & NFT Integration (Advanced Concepts)

**Scenario:** A DeFi protocol experiences the following sequence of events:

- A liquidity provider adds 10 ETH and 20,000 USDC to an AMM pool (constant product formula: x × y = k)  
- A trader swaps 2 ETH for USDC (no fees for simplicity)  
- The protocol's governance token holders vote on implementing impermanent loss protection  
- An NFT marketplace integrates with the DEX to enable ERC-1155 token swaps  

---

### Question: Multi-Concept Synthesis

**Which statement correctly combines understanding of AMMs, governance, and technical implementation?**

- **A)** After the 2 ETH swap, the liquidity provider will have exactly the same USD value as before because the constant product formula maintains equal ratios. ERC-1155 tokens cannot be traded on AMMs since they support both fungible and non-fungible characteristics.  
- **B)** The trader will receive approximately 3,333 USDC from the swap (calculated using k = 10 × 20,000 = 200,000, then 12 × y = 200,000). Impermanent loss protection would compensate the LP for price divergence between the pool ratio and external market prices. ERC-1155's batch transfer capability makes it more gas-efficient than ERC-721 for marketplace integration.  
- **C)** The liquidity provider experiences impermanent loss because the pool maintains a constant product rather than constant ratio. ERC-721 would be more suitable than ERC-1155 for the NFT marketplace since individual NFTs require unique transactions.  
- **D)** The constant product formula prevents any impermanent loss by automatically rebalancing. DAOs cannot implement financial protections due to smart contract immutability. ERC-1155 tokens are incompatible with standard DEX protocols.  

**Your Answer:** B  

**Your Reasoning:**  

- **AMM Mathematics:** How do you calculate the swap output? What happens to the liquidity provider's value?  
- **DeFi Governance:** What is impermanent loss and how does protection work?  
- **Token Standards:** Why might ERC-1155 be preferred over ERC-721 for marketplace integration?  

the math is: k = 10 × 20,000 = 200,000.
After adding 2 ETH (12 ETH total), y = 200,000 / 12 = 16,666.67 USDC, so the trader gets about 3,333 USDC. Impermanent loss protection helps LPs when prices move outside the pool. ERC‑1155 is better for a marketplace because it can batch transfers and is cheaper for lots of items.  

---

## SUBMISSION CHECKLIST

- You answered all questions for **BOTH PART 1 AND PART 2**  
- Your answers include reasoning (not just A/B/C/D)  
- For PART 1 Q2: You showed your gas cost calculations  
- For PART 2: You addressed all three concept areas (AMM, Governance, Token Standards)  
- You committed and pushed to GitLab  

---

**Challenges faced:** The gas options don’t match my calculation, so I picked the closest and explained it. I’m still getting comfortable with impermanent loss and how randomness should be done safely.  
