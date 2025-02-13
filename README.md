# CryptoChord - Blockchain-Based Music Copyright Protection System

## 1. Introduction
This project is a blockchain-based solution designed to empower new and independent music artists by providing a decentralized, secure, and cost-effective platform for copyright protection, ownership verification, and monetization. By leveraging blockchain technology and NFTs (Non-Fungible Tokens), the system ensures transparency, immutability, and efficiency in managing intellectual property rights for music.

---

## 2. Problem Statement
New and independent music artists often face significant challenges in protecting their intellectual property. Traditional copyright registration processes are expensive, time-consuming, and inaccessible for many emerging artists. Additionally, music piracy and unauthorized use of their creations pose a constant threat to their rights and revenue. This project aims to address these issues by providing a blockchain-based solution that simplifies copyright registration, ensures ownership verification, and enables monetization through NFTs.

---

## 3. Key Features
- **Copyright Registration**: Artists can register their music on the blockchain to establish ownership.
- **Ownership Verification**: A transparent and immutable record of ownership is maintained for easy verification.
- **Monetization**: Artists can mint NFTs representing their music and sell or license them on a decentralized marketplace.
- **Royalty Distribution**: Automated royalty payments ensure that artists and other stakeholders receive their fair share of revenue.
- **Dispute Resolution**: A mechanism is provided to handle disputes related to copyright or ownership.
- **Single-Owner Management**: All critical actions are controlled by a single owner, ensuring centralized management and security.

---

## 4. Approach in Detail
The system is designed to provide a seamless experience for artists to protect and monetize their music. Below is the detailed approach:

### Step 1: Register Music Metadata
- Artists register their music in the **MusicRegistry.sol** contract.
- Metadata such as title, artist, hash (unique identifier for the music file), and timestamp are stored on the blockchain.

### Step 2: Mint NFTs
- Artists mint NFTs representing their music using the **MusicNFT.sol** contract.
- Each NFT is unique and tied to the registered music metadata.

### Step 3: List NFTs for Sale
- Artists list their NFTs for sale or licensing on the **Marketplace.sol** contract.
- Buyers can purchase NFTs using cryptocurrency, and ownership is transferred automatically.

### Step 4: Distribute Royalties
- The **RoyaltyDistribution.sol** contract allows artists to set up royalty payments.
- When an NFT is sold or licensed, royalties are automatically distributed to the specified recipients.

### Step 5: Handle Disputes
- If a dispute arises (e.g., unauthorized use of music), it can be filed in the **DisputeResolution.sol** contract.
- The owner (or an administrator) resolves the dispute, updating ownership or other details if necessary.

### Step 6: Register Copyrights
- Artists register their copyrights in the **Copyright.sol** contract.
- This establishes legal ownership and allows for the transfer of copyrights if needed.

---

## 5. Smart Contracts Overview
The system consists of the following smart contracts:

### 1. **MusicRegistry.sol**
- **Purpose**: Registers music metadata (title, artist, hash, timestamp).
- **Key Functions**:
  - `registerMusic`: Registers a new music piece.
  - `getMusic`: Retrieves music metadata.

### 2. **MusicNFT.sol**
- **Purpose**: Mints NFTs representing ownership of music.
- **Key Functions**:
  - `mint`: Mints a new NFT.
  - `tokenURI`: Returns the URI of the NFT metadata.

### 3. **Marketplace.sol**
- **Purpose**: Facilitates buying, selling, and licensing of music NFTs.
- **Key Functions**:
  - `listForSale`: Lists an NFT for sale.
  - `buyMusic`: Allows users to buy listed NFTs.

### 4. **RoyaltyDistribution.sol**
- **Purpose**: Manages royalty payments for music usage.
- **Key Functions**:
  - `addRoyalty`: Adds royalty recipients and percentages.
  - `distributeRoyalties`: Distributes royalties to recipients.

### 5. **DisputeResolution.sol**
- **Purpose**: Handles disputes related to copyright or ownership.
- **Key Functions**:
  - `fileDispute`: Files a new dispute.
  - `resolveDispute`: Resolves a dispute.

### 6. **Copyright.sol**
- **Purpose**: Registers and manages copyrights for music.
- **Key Functions**:
  - `registerCopyright`: Registers a new copyright.
  - `verifyOwnership`: Verifies copyright ownership.
  - `transferCopyright`: Transfers copyright ownership.

### 7. **Lock.sol**
- **Purpose**: A simple time-locked contract that restricts withdrawals until a specified unlock time.
- **Key Functions**:
  - `constructor(uint _unlockTime)`: Initializes the contract with an unlock time and sets the contract owner.
  - `withdraw()`: Allows the owner to withdraw funds after the unlock time has passed.

---

## 6. Project Structure

### 6.1. Paths
- **Smart Contracts**: All Solidity smart contracts are stored in the `web3/contracts/` directory.
- **Tests**: Unit and integration tests are located in the `web3/test/` directory.
- **Scripts**: Deployment and utility scripts are stored in the `web3/scripts/` directory.

### 6.2. Artifacts Folder
The `artifacts/` folder contains the compiled and tested output files of your Solidity contracts. This includes:
- **ABI (Application Binary Interface)**: JSON files that describe the contract's interface.
- **Bytecode**: The compiled bytecode of the contracts, ready for deployment.
- **Metadata**: Additional information about the contracts, such as source code hashes.

To generate the artifacts, run the following command:
```sh
npx hardhat compile
```

---

## 7. Tech Stack

| Technology       | Description                                           | Icon |
|-----------------|-------------------------------------------------------|------|
| **React.js**    | A JavaScript library for building user interfaces.     | ![React](https://img.shields.io/badge/-React-61DAFB?logo=react&logoColor=white) |
| **Node.js**     | JavaScript runtime environment for server-side scripting. | ![Node.js](https://img.shields.io/badge/-Node.js-339933?logo=node.js&logoColor=white) |
| **Express.js**  | Fast, unopinionated web framework for Node.js.         | ![Express.js](https://img.shields.io/badge/-Express.js-000000?logo=express&logoColor=white) |
| **MongoDB**     | NoSQL database for flexible and scalable data storage. | ![MongoDB](https://img.shields.io/badge/-MongoDB-47A248?logo=mongodb&logoColor=white) |
| **Solidity**    | Smart contract programming language for Ethereum.      | ![Solidity](https://img.shields.io/badge/-Solidity-363636?logo=solidity&logoColor=white) |
| **Web3.js**     | JavaScript library for interacting with Ethereum blockchain. | ![Web3.js](https://img.shields.io/badge/-Web3.js-EF6C00?logo=ethereum&logoColor=white) |
| **Hardhat**     | Ethereum development environment and testing framework. | ![Hardhat](https://img.shields.io/badge/-Hardhat-FFCA28?logo=hardhat&logoColor=black) |
| **Metamask**    | Browser extension for managing Ethereum wallets.       | ![Metamask](https://img.shields.io/badge/-Metamask-F6851B?logo=metamask&logoColor=white) |
| **Polygon**     | Layer 2 scaling solution for Ethereum.                 | ![Polygon](https://img.shields.io/badge/-Polygon-8247E5?logo=polygon&logoColor=white) |
| **Tailwind CSS**| A utility-first CSS framework for styling.             | ![Tailwind CSS](https://img.shields.io/badge/-Tailwind%20CSS-38B2AC?logo=tailwind-css&logoColor=white) |

---

## 8. Workflow Flowchart
![flowchart](https://github.com/user-attachments/assets/462a59c0-caec-4650-9bb4-a0c08450cef4)
