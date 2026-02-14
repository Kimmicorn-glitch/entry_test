# Part B: Test Scenarios Guide

**Complete test scenarios for BOTH contracts.**

---

## Test Scenario 1: SkillsMarketplace
**Target:** `SkillsMarketplace.sol`

### 1.1 Happy Path
**Description**: Test successful gig posting and payment.
- **Steps**: Register a worker with a skill, post a gig with matching skill and ETH, have the worker apply, submit work, then employer approves and pays.
- **Expected Result**: Gig moves Open -> Submitted -> Completed, worker receives bounty, and events are emitted.

### 1.2 Security/Edge Case
**Description**: Attempt reentrancy or unauthorized access.
- **Steps**: Try to approve a gig from a non‑employer address, and try to call approve twice. (If I have time: simulate a reentrancy attack contract.)
- **Expected Result**: Non‑employer approval fails, double approval fails, and reentrancy should be blocked.

---

## Test Scenario 2: SecureLottery
**Target:** `SecureLottery.sol`

### 2.1 Happy Path
**Description**: Test entry and winner selection.
- **Steps**: Have 3+ unique players enter with 0.01 ETH or more, wait 24 hours (or fast‑forward in tests), then owner selects winner.
- **Expected Result**: Winner gets 90% of pot, owner gets 10%, lottery resets for next round.

### 2.2 Security/Edge Case
**Description**: Test randomness manipulation or insufficient funds.
- **Steps**: Try to select winner before 24 hours or with <3 unique players. Try to enter with less than 0.01 ETH. (Not fully sure how to test randomness manipulation yet.)
- **Expected Result**: Early select fails, low ETH entry fails, randomness manipulation is not trivial.

---

## Coverage Assessment
After implementing your tests in `test/`, assess your coverage:
1. **Link to test files:** `test/SkillsMarketplace.test.js`, `test/SecureLottery.test.js` (planned)
2. **Key functions tested:** registerWorker, postGig, applyForGig, submitWork, approveAndPay, enter, selectWinner, pause/unpause
3. **Estimated Coverage:** not sure yet, but aiming for most state transitions

> [!TIP]
> Use `npx hardhat coverage` if you have the plugin installed, otherwise manually verify all state transitions are tested.
