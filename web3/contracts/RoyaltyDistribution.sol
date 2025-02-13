// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


/**
 * @title RoyaltyDistribution
 * @dev A contract to manage royalty payments for music usage.
 * The owner can add royalty recipients and distribute royalties to them.
 */
contract RoyaltyDistribution is Ownable, ReentrancyGuard {
    struct Royalty {
        address recipient; // Address of the royalty recipient
        uint256 percentage; // Percentage of royalties the recipient receives
    }

    // Mapping from music ID to an array of royalty recipients
    mapping(uint256 => Royalty[]) public royalties;

    // Total royalties percentage for a given music ID
    mapping(uint256 => uint256) public totalRoyalties;

    // Events
    event RoyaltyAdded(uint256 indexed musicId, address recipient, uint256 percentage);
    event RoyaltyDistributed(uint256 indexed musicId, address recipient, uint256 amount);

    /**
     * @dev Adds a royalty recipient for a specific music ID.
     * @param musicId The ID of the music.
     * @param recipient The address of the royalty recipient.
     * @param percentage The percentage of royalties the recipient should receive.
     */
    function addRoyalty(uint256 musicId, address recipient, uint256 percentage) public onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(percentage > 0 && percentage <= 100, "Invalid percentage");

        // Ensure the total royalties do not exceed 100%
        totalRoyalties[musicId] += percentage;
        require(totalRoyalties[musicId] <= 100, "Total royalties exceed 100%");

        // Add the royalty recipient
        royalties[musicId].push(Royalty({
            recipient: recipient,
            percentage: percentage
        }));

        emit RoyaltyAdded(musicId, recipient, percentage);
    }

    /**
     * @dev Distributes royalties to recipients for a specific music ID.
     * @param musicId The ID of the music.
     */
    function distributeRoyalties(uint256 musicId) public payable nonReentrant {
        require(msg.value > 0, "Amount must be greater than 0");

        // Get the list of royalty recipients for the music ID
        Royalty[] memory royaltyList = royalties[musicId];

        // Distribute royalties to each recipient
        for (uint256 i = 0; i < royaltyList.length; i++) {
            uint256 share = (msg.value * royaltyList[i].percentage) / 100;
            payable(royaltyList[i].recipient).transfer(share);

            emit RoyaltyDistributed(musicId, royaltyList[i].recipient, share);
        }
    }

    /**
     * @dev Returns the list of royalty recipients for a specific music ID.
     * @param musicId The ID of the music.
     * @return recipients An array of royalty recipients and their percentages.
     */
    function getRoyalties(uint256 musicId) public view returns (Royalty[] memory) {
        return royalties[musicId];
    }
}