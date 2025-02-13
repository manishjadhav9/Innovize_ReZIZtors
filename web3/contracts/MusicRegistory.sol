// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MusicRegistry is Ownable {
    struct Music {
        string title;
        string artist;
        string hash;
        uint256 timestamp;
        bool registered;
    }
    mapping(uint256 => Music) public musicRegistry;
    uint256 public musicCount;

    event MusicRegistered(uint256 id, string title, string artist, string hash, uint256 timestamp);

    // Constructor to initialize the contract with an initial owner
    constructor(address initialOwner) Ownable(initialOwner) {
        // You can add additional initialization logic here if needed
    }

    function registerMusic(string memory title, string memory artist, string memory hash) public onlyOwner {
        musicCount++;
        musicRegistry[musicCount] = Music({
            title: title,
            artist: artist,
            hash: hash,
            timestamp: block.timestamp,
            registered: true
        });

        emit MusicRegistered(musicCount, title, artist, hash, block.timestamp);
    }

    function getMusic(uint256 id) public view returns (string memory, string memory, string memory, uint256, bool) {
        require(id <= musicCount && id > 0, "Music ID does not exist");
        Music memory music = musicRegistry[id];
        return (music.title, music.artist, music.hash, music.timestamp, music.registered);
    }

    // Add a receive function to reject plain Ether transfers
    receive() external payable {
        revert("Ether transfers not allowed");
    }

    // Add a fallback function to reject invalid function calls or Ether transfers with data
    fallback() external payable {
        revert("Invalid function call");
    }
}