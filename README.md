# Decentralized Staking

## Description

A decentralized application where users can coordinate a group funding effort. If the users cooperate, the money is collected in a second smart contract. If they defect, the worst that can happen is everyone gets their money back.

## Installation and Setup Instructions

### Prerequisites

- Node (v18 LTS)
- Yarn (v1 or v2+)
- Git

### Clone the Repository

To get started, clone the repository to your local machine:

```bash
git clone https://github.com/dianakocsis/decentralized-staking
```

### Environment Setup

1. Navigate to the cloned directory:

   ```bash
   cd decentralized-staking
   ```

2. Copy the .env.example files to create a new .env file and fill in the necessary details:

   ```bash
   cp .env.example .env
   ```

   ```bash
   cd frontend
   cp .env.example .env
   ```

### Environment Setup

1. Install Dependencies

   To install project dependencies, run the following commands:

   ```bash
   yarn install
   cd frontend && yarn install
   cd ..
   ```

2. Start Local Blockchain

   In a new terminal, start the local blockchain:

   ```bash
   yarn chain
   ```

3. Deploy Contracts (In another tab)

   Open another terminal tab and deploy the contracts:

   ```bash
   yarn deploy
   ```

4. Start the Aplication (In another tab)

   Finally, in a new terminal tab, start the application:

   ```bash
   yarn start
   ```

## Testnet Deploy Information

| Contract                | Address Etherscan Link                                                            |
| ----------------------- | --------------------------------------------------------------------------------- |
| Staker                  | `https://sepolia.etherscan.io/address/0xc43E47625DF5B6B5D0ad6C1C137ec5a68CBaD485` |
| ExampleExternalContract | `https://sepolia.etherscan.io/address/0xcB73e0BB591e9e3F2684b0C68312Cb0149B2c6ca` |
