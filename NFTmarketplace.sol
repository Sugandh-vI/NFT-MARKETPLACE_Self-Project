// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTMarketplace is ERC721URIStorage, ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; // Counter for NFT IDs

    struct MarketItem {
        uint tokenId;
        address payable seller;
        address payable owner;
        uint price; // stored in Wei internally
        bool sold;
    }

    mapping(uint => MarketItem) public idToMarketItem;

    event NFTMinted(uint tokenId, address owner, string tokenURI);
    event NFTListed(uint tokenId, address seller, uint price);
    event NFTSold(uint tokenId, address buyer, uint price);

    constructor() ERC721("MyNFT", "MNFT") {}

    // Mint a new NFT and store metadata URI
    function mintNFT(string memory tokenURI) external returns (uint) {
        _tokenIds.increment();
        uint newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        emit NFTMinted(newTokenId, msg.sender, tokenURI);
        return newTokenId;
    }

    // List NFT for sale by transferring to marketplace
    // Price input in Ether, converted to Wei internally
    function listNFT(uint tokenId, uint priceInEther) external nonReentrant {
        require(ownerOf(tokenId) == msg.sender, "Not the owner");
        require(priceInEther > 0, "Price must be positive");

        transferFrom(msg.sender, address(this), tokenId);

        idToMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            priceInEther * 1 ether, // Convert Ether to Wei
            false
        );

        emit NFTListed(tokenId, msg.sender, priceInEther * 1 ether);
    }

    // Buy a listed NFT
    function buyNFT(uint tokenId) external payable nonReentrant {
        MarketItem storage item = idToMarketItem[tokenId];
        require(msg.value >= item.price, "Insufficient payment");
        require(!item.sold, "Already sold");

        item.owner = payable(msg.sender);
        item.sold = true;

        // Transfer NFT to buyer
        _transfer(address(this), msg.sender, tokenId);

        // Pay the seller
        item.seller.transfer(item.price);

        emit NFTSold(tokenId, msg.sender, item.price);
    }

    // Fetch all NFTs listed on marketplace
    function fetchMarketItems() external view returns (MarketItem[] memory) {
        uint itemCount = _tokenIds.current();
        uint unsoldCount = 0;
        uint currentIndex = 0;

        for (uint i = 1; i <= itemCount; i++) {
            if (!idToMarketItem[i].sold) {
                unsoldCount++;
            }
        }

        MarketItem[] memory items = new MarketItem[](unsoldCount);
        for (uint i = 1; i <= itemCount; i++) {
            if (!idToMarketItem[i].sold) {
                items[currentIndex] = idToMarketItem[i];
                currentIndex++;
            }
        }

        return items;
    }

    // Fetch NFTs owned by a user
    function fetchMyNFTs() external view returns (MarketItem[] memory) {
        uint totalCount = _tokenIds.current();
        uint ownedCount = 0;
        uint currentIndex = 0;

        for (uint i = 1; i <= totalCount; i++) {
            if (idToMarketItem[i].owner == msg.sender) {
                ownedCount++;
            }
        }

        MarketItem[] memory items = new MarketItem[](ownedCount);
        for (uint i = 1; i <= totalCount; i++) {
            if (idToMarketItem[i].owner == msg.sender) {
                items[currentIndex] = idToMarketItem[i];
                currentIndex++;
            }
        }

        return items;
    }
}
