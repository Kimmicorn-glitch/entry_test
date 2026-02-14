// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title SkillsMarketplace
 * @dev A decentralised marketplace for skills and gigs
 * @notice PART 1 - Skills Marketplace (MANDATORY)
 */
contract SkillsMarketplace {
    
    struct Worker {
        string skill;
        bool registered;
    }

    enum GigStatus {
        Open,
        Submitted,
        Completed
    }

    struct Gig {
        address employer;
        string description;
        string skillRequired;
        uint256 bounty;
        GigStatus status;
    }
    
    address public owner;
    mapping(address => Worker) public workers;
    Gig[] public gigs;
    mapping(uint256 => mapping(address => bool)) public hasApplied;
    mapping(uint256 => mapping(address => bool)) public hasSubmitted;
    mapping(uint256 => mapping(address => string)) public submissions;

    event WorkerRegistered(address indexed worker, string skill);
    event GigPosted(uint256 indexed gigId, address indexed employer, uint256 bounty);
    event GigApplied(uint256 indexed gigId, address indexed worker);
    event WorkSubmitted(uint256 indexed gigId, address indexed worker, string submissionUrl);
    event GigApproved(uint256 indexed gigId, address indexed employer, address indexed worker, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    // TODO: Implement registerWorker function
    // Requirements:
    // - Workers should be able to register with their skill
    // - Prevent duplicate registrations
    // - Emit an event when a worker registers
    function registerWorker(string memory skill) public {
        require(bytes(skill).length > 0, "Skill requried");
        require(!workers[msg.sender].registered, "Already regstered");
        workers[msg.sender] = Worker({skill: skill, registered: true});
        emit WorkerRegistered(msg.sender, skill);
    }
    
    // TODO: Implement postGig function
    // Requirements:
    // - Employers post gigs with bounty (msg.value)
    // - Store gig description and required skill
    // - Ensure ETH is sent with the transaction
    // - Emit an event when gig is posted
    function postGig(string memory description, string memory skillRequired) public payable {
        require(msg.value > 0, "Bounty requred");
        require(bytes(description).length > 0, "Description requried");
        require(bytes(skillRequired).length > 0, "Skill requried");

        Gig memory gig = Gig({
            employer: msg.sender,
            description: description,
            skillRequired: skillRequired,
            bounty: msg.value,
            status: GigStatus.Open
        })

        gigs.push(gig);
        emit GigPosted(gigs.length - 1, msg.sender, msg.value);
    }
    
    // TODO: Implement applyForGig function
    // Requirements:
    // - Workers can apply for gigs
    // - Check if worker has the required skill
    // - Prevent duplicate applications
    // - Emit an event
    function applyForGig(uint256 gigId) public {
        require(gigId < gigs.length, "Invaid gig");
        require(workers[msg.sender].registered, "Not registered");
        require(gigs[gigId].status == GigStatus.Open, "Not open");
        require(!hasApplied[gigId][msg.sender], "Already applied");
        require(isRightSkill(msg.sender, gigId), "Skill mismatch");
        require(
            keccak256(bytes(workers[msg.sender].skill)) ==
                keccak256(bytes(gigs[gigId].skillRequired)),
            "Skill mismatch"
        );

        hasApplied[gigId][msg.sender] = true;
        emit GigApplied(gigId, msg.sender);
    }
    
    // TODO: Implement submitWork function
    // Requirements:
    // - Workers submit completed work (with proof/URL)
    // - Validate that worker applied for this gig
    // - Update gig status
    // - Emit an event
    function submitWork(uint256 gigId, string memory submissionUrl) public {
        require(gigId < gigs.length, "Invaid gig");
        require(hasApplied[gigId][msg.sender], "Not applied");
        require(bytes(submissionUrl).length > 0, "Submission requried");
        require(!hasSubmitted[gigId][msg.sender], "Already submitted");

        submissions[gigId][msg.sender] = submissionUrl;
        hasSubmitted[gigId][msg.sender] = true;
        gigs[gigId].status = GigStatus.Submitted;
        emit WorkSubmitted(gigId, msg.sender, submissionUrl);
    }
    
    // TODO: Implement approveAndPay function
    // Requirements:
    // - Only employer who posted gig can approve
    // - Transfer payment to worker
    // - CRITICAL: Implement reentrancy protection
    // - Update gig status to completed
    // - Emit an event
    function approveAndPay(uint256 gigId, address worker) public {
        require(gigId < gigs.length, "Invaid gig");
        Gig storage gig = gigs[gigId];
        require(msg.sender == gig.employer, "Not employer");
        require(gig.status == GigStatus.Submitted, "Not submited");
        require(hasSubmitted[gigId][worker], "No submision");
        require(isRightSkill(worker, gigId), "Skill mismatch");

        uint256 amount = gig.bounty
        gig.bounty = 0;
        gig.status = GigStatus.Completed;

        (bool ok, ) = worker.call{value: amount}("");
        require(ok, "Payment failed");
        emit GigApproved(gigId, msg.sender, worker, amount);
    }
    
    // BONUS: Implement dispute resolution
    // What happens if employer doesn't approve but work is done?
    // Consider implementing a timeout mechanism
    
    // Helper functions you might need:
    // - Function to get gig details
    // - Function to check worker registration
    // - Function to get all gigs
}
