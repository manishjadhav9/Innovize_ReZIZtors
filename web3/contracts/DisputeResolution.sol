// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DisputeResolution is Ownable {
    struct Dispute {
        uint256 musicId;
        address claimant;
        string description;
        bool resolved;
    }

    mapping(uint256 => Dispute) public disputes;
    uint256 public disputeCount;

    event DisputeFiled(uint256 disputeId, uint256 musicId, address claimant, string description);
    event DisputeResolved(uint256 disputeId, uint256 musicId, address claimant);

    constructor(address initialOwner) Ownable(initialOwner) {}

    function fileDispute(uint256 musicId, string memory description) public {
        disputeCount++;
        disputes[disputeCount] = Dispute({
            musicId: musicId,
            claimant: msg.sender,
            description: description,
            resolved: false
        });

        emit DisputeFiled(disputeCount, musicId, msg.sender, description);
    }

    function resolveDispute(uint256 disputeId) public onlyOwner {
        require(!disputes[disputeId].resolved, "Dispute already resolved");

        disputes[disputeId].resolved = true;
        emit DisputeResolved(disputeId, disputes[disputeId].musicId, disputes[disputeId].claimant);
    }
} 