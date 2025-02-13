// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Copyright is Ownable {
    struct CopyrightInfo {
        address owner;
        string title;
        string artist;
        string hash;
        uint256 registrationDate;
        bool isRegistered;
    }

    mapping(uint256 => CopyrightInfo) public copyrights;
    uint256 public copyrightCount;

    event CopyrightRegistered(uint256 id, address owner, string title, string artist, string hash, uint256 registrationDate);
    event CopyrightTransferred(uint256 id, address previousOwner, address newOwner);

    constructor(address initialOwner) Ownable(initialOwner) {}

    function registerCopyright(string memory title, string memory artist, string memory hash) public {
        copyrightCount++;
        copyrights[copyrightCount] = CopyrightInfo({
            owner: msg.sender,
            title: title,
            artist: artist,
            hash: hash,
            registrationDate: block.timestamp,
            isRegistered: true
        });

        emit CopyrightRegistered(copyrightCount, msg.sender, title, artist, hash, block.timestamp);
    }

    function verifyOwnership(uint256 id) public view returns (address, string memory, string memory, string memory, uint256, bool) {
        require(id <= copyrightCount && id > 0, "Copyright ID does not exist");
        CopyrightInfo memory copyright = copyrights[id];
        return (copyright.owner, copyright.title, copyright.artist, copyright.hash, copyright.registrationDate, copyright.isRegistered);
    }

    function transferCopyright(uint256 id, address newOwner) public {
        require(id <= copyrightCount && id > 0, "Copyright ID does not exist");
        require(copyrights[id].owner == msg.sender, "You do not own this copyright");
        require(newOwner != address(0), "Invalid new owner address");

        address previousOwner = copyrights[id].owner;
        copyrights[id].owner = newOwner;

        emit CopyrightTransferred(id, previousOwner, newOwner);
    }
} 