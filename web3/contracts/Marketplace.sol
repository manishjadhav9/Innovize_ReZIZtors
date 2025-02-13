// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Marketplace is Ownable {
    struct Listing {
        uint256 price;
        address seller;
        bool isListed;
    }

    mapping(uint256 => Listing) public listings;
    IERC721 public musicNFT;

    constructor(address _musicNFT, address initialOwner) Ownable(initialOwner) {
        musicNFT = IERC721(_musicNFT);
    }

    event MusicListed(uint256 tokenId, uint256 price, address seller);
    event MusicSold(uint256 tokenId, address buyer, uint256 price);

    function listForSale(uint256 tokenId, uint256 price) public {
        require(musicNFT.ownerOf(tokenId) == msg.sender, "You do not own this NFT");
        require(price > 0, "Price must be greater than 0");

        listings[tokenId] = Listing({
            price: price,
            seller: msg.sender,
            isListed: true
        });

        emit MusicListed(tokenId, price, msg.sender);
    }

    function buyMusic(uint256 tokenId) public payable {
        Listing memory listing = listings[tokenId];
        require(listing.isListed, "This NFT is not listed for sale");
        require(msg.value >= listing.price, "Insufficient funds");

        address seller = listing.seller;
        listings[tokenId].isListed = false;

        musicNFT.safeTransferFrom(seller, msg.sender, tokenId);
        payable(seller).transfer(msg.value);

        emit MusicSold(tokenId, msg.sender, listing.price);
    }
} 