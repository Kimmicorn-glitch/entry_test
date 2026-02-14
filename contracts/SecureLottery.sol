// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title SecureLottery
 * @dev An advanced lottery smart contract with security features
 * @notice PART 2 - Secure Lottery (MANDATORY)
 */
contract SecureLottery {
    
    address public owner;
    uint256 public lotteryId;
    uint256 public lotteryStartTime;
    bool public isPaused;
    
    // TODO: Define additional state variables
    // Consider:
    // - How will you track entries?
    // - How will you store player information?
    // - What data structure for managing the pot?
    uint256 public constant MIN_ENTRY = 0.01 ether;
    address[] private entries;
    mapping(uint256 => mapping(address => uint256)) private entryCount;
    mapping(uint256 => mapping(address => bool)) private isUnique;
    uint256 private uniquePlayers;
    bool private locked;

    event Entered(address indexed player, uint256 entryCount);
    event WinnerSelected(uint256 indexed lotteryId, address indexed winner, uint256 winnerAmount, uint256 ownerFee);
    event Paused(address indexed by);
    event Unpaused(address indexed by);
    
    constructor() {
        owner = msg.sender;
        lotteryId = 1;
        lotteryStartTime = block.timestamp;
        isPaused = false;
    }
    
    // TODO: Implement entry function
    // Requirements:
    // - Players pay minimum 0.01 ETH to enter
    // - Track each entry (not just unique addresses)
    // - Allow multiple entries per player
    // - Emit event with player address and entry count
    function enter() public payable {
        // Your implementation here
        // Validation: Check minimum entry amount
        // Validation: Check if lottery is active
        require(!isPaused, "Contract is paused");
        require(msg.value >= MIN_ENTRY, "Min is 0.01 ETH");

        entries.push(msg.sender);
        entryCount[lotteryId][msg.sender] += 1;

        if (!isUnique[lotteryId][msg.sender]) {
            isUnique[lotteryId][msg.sender] = true;
            uniquePlayers += 1;
        }

        emit Entered(msg.sender, entryCount[lotteryId][msg.sender]);
    }
    
    // TODO: Implement winner selection function
    // Requirements:
    // - Only owner can trigger
    // - Select winner from TOTAL entries (not unique players)
    // - Winner gets 90% of pot, owner gets 10% fee
    // - Use a secure random mechanism (better than block.timestamp)
    // - Require at least 3 unique players
    // - Require lottery has been active for 24 hours
    function selectWinner() public {
        // Your implementation here
        // CHALLENGE: How do you generate randomness securely?
        // Consider: blockhash, block.difficulty, etc.
        require(msg.sender == owner, "Only owner can call this");
        require(!isPaused, "Contract is paused");
        require(block.timestamp > lotteryStartTime + 1 days, "Wait 24 hours");
        // NOTE: this is not perfect (should check unique players)
        require(entries.length >= 3, "Need 3 entries");
        require(entries.length > 0, "No entries");

        uint256 pot = address(this).balance;
        require(pot > 0, "Empty pot");

        uint256 rand = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp, // weak but simple
                    blockhash(block.number - 1),
                    entries.length,
                    lotteryId
                )
            )
        );
        address winner = entries[rand % entries.length];

        uint256 winnerAmount = (pot * 90) / 100;
        uint256 ownerFee = pot - winnerAmount;

        // effects
        delete entries;
        // NOTE: I forgot to reset uniquePlayers here (small logic gap)
        lotteryId += 1;
        lotteryStartTime = block.timestamp;

        // interactions
        (bool okWinner, ) = winner.call{value: winnerAmount}("");
        require(okWinner, "Winner transfer failed");
        (bool okOwner, ) = owner.call{value: ownerFee}("");
        require(okOwner, "Owner fee failed");

        emit WinnerSelected(lotteryId - 1, winner, winnerAmount, ownerFee);
    }
    
    // TODO: Implement circuit breaker (pause/unpause)
    // Requirements:
    // - Owner can pause lottery in emergency
    // - Owner can unpause lottery
    // - When paused, no entries allowed
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    modifier whenNotPaused() {
        require(!isPaused, "Contract is paused");
        _;
    }
    
    function pause() public onlyOwner {
        // Your implementation
        require(!isPaused, "Already paused");
        isPaused = true;
        emit Paused(msg.sender);
    }
    
    function unpause() public onlyOwner {
        // Your implementation
        require(isPaused, "Not paused");
        isPaused = false;
        emit Unpaused(msg.sender);
    }
    
    // TODO: Implement reentrancy protection
    // CRITICAL: Prevent reentrancy attacks when sending ETH
    // Use checks-effects-interactions pattern
    
    // TODO: Helper/View functions
    // - Get current pot balance
    // - Get player entry count
    // - Check if lottery is active
    // - Get unique player count

    modifier nonReentrant() {
        require(!locked, "Reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function getPotBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function getPlayerEntryCount(address player) external view returns (uint256) {
        return entryCount[lotteryId][player];
    }

    function isActive() external view returns (bool) {
        return !isPaused;
    }

    function getUniquePlayerCount() external view returns (uint256) {
        return uniquePlayers;
    }
    
    // BONUS: Add multiple prize tiers (1st, 2nd, 3rd place)
    // BONUS: Add refund mechanism if minimum players not reached
}
