# NFT Marketplace

## Project Description
This project is a **decentralized NFT Marketplace** built on Ethereum using Solidity. It allows users to **mint, list, and buy NFTs** directly from a smart contract. Each NFT is a unique digital asset represented by the **ERC721 standard**, and all marketplace operations are recorded on the blockchain, ensuring **security, transparency, and true ownership**.  

The main goal of this project is to **demonstrate blockchain-based asset ownership and marketplace functionality** while creating a professional portfolio project showcasing smart contract development skills.

---

## Problem Statement
Traditional digital marketplaces rely on **centralized platforms**, which:
- Control the sale and ownership of digital assets.
- Charge high fees for transactions.
- Are vulnerable to hacks and data manipulation.

This NFT Marketplace addresses these issues by:
- Giving **true ownership** of NFTs to users.
- Allowing **direct peer-to-peer buying and selling** without intermediaries.
- Ensuring **secure and transparent transactions** on the blockchain.

---

## Real-World Relevance
NFT marketplaces are widely used in:
- Digital art platforms (e.g., OpenSea, Rarible)
- Gaming assets and collectibles
- Digital certificates and event tickets

This project simulates a **real-world NFT marketplace**, providing practical insights into blockchain technology and NFT-based applications.

---

## Features
1. **Mint NFTs** – Users can create unique NFTs with metadata URIs.  
2. **List NFTs for Sale** – NFTs can be listed for a specific price in Ether.  
3. **Buy NFTs** – Users can purchase listed NFTs securely.  
4. **Fetch Market Items** – View all unsold NFTs on the marketplace.  
5. **Fetch My NFTs** – View all NFTs owned by the caller.

---

## Code Explanation

### Smart Contract Overview
- Written in **Solidity 0.8.27**.  
- Inherits **ERC721URIStorage** for NFT functionality.  
- Uses **Counters** for unique token IDs.  
- Includes **ReentrancyGuard** to prevent reentrancy attacks.

### Key Data Structures
- **MarketItem**: Stores information about each NFT, including its token ID, seller, owner, price, and sale status.  
- **idToMarketItem**: Maps each NFT token ID to its corresponding marketplace item details for easy lookup.

### Function Explanations
1. **mintNFT** – Allows a user to mint a new NFT. The user provides a token URI, which stores metadata about the NFT. Once minted, the NFT is assigned a unique ID and ownership is attributed to the minter.  

2. **listNFT** – Lets the NFT owner list their NFT for sale in the marketplace. The owner specifies the price in Ether. The NFT is transferred to the marketplace contract, which holds it until it is sold.  

3. **buyNFT** – Enables another user to purchase a listed NFT. Upon payment, ownership of the NFT is transferred to the buyer, and the seller receives the payment in Ether. The sale status of the NFT is updated to prevent double selling.  

4. **fetchMarketItems** – Returns all NFTs that are currently listed for sale and not yet sold. This function helps users view all available items in the marketplace.  

5. **fetchMyNFTs** – Returns all NFTs owned by the caller, allowing users to track their personal collection of NFTs.

## Technologies Used
- **Solidity** – Smart contract development.  
- **OpenZeppelin** – ERC721 standards and security utilities.  
- **Remix IDE** – Development and testing environment.  
- **JavaScript VM / Ethereum Testnet** – Simulated blockchain for testing.

---

## Author
**Sugandh Kumar** – Blockchain Enthusiast | Portfolio Project



