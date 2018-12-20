# Programming Blockchain Applications: Chapter 4 - MyERC20Token
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](https://opensource.org/licenses/MIT)

<img src="../chainfabric-logo.png" alt="ChainFabric" width="287px">

This folder contains the source code of "MyERC20Token" token as described in chapter 4 of the "Programming Blockchain Applications" book.

# Requirements
```
sudo apt install -y build-essential
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
```

# Dependencies

 * **[Solc-js](https://github.com/ethereum/solc-js)**: Compiler for Solidity programming language.
 * **[Mocha](https://mochajs.org/)**: Javascript test framework.
 * **[Ganache-cli](https://www.npmjs.com/package/ganache-cli)**: Deployment solution for Ethereum blockchain network.
 * **[Web3.js](https://github.com/ethereum/web3.js/)**: Javascript library for integration with the nodes on Ethereum blockchain network.
 * **[Truffle-hdwallet-provider](https://github.com/trufflesuite/truffle-hdwallet-provider)**: Hierarchical Deterministic Wallet provider.

# Installation

Once the repository cloned, please run the commands below to download all dependencies.

```
npm i --save

```

You'll need to sign-up on **[Infura.io](https://infura.io/)** to retrieve public endpoints on Ethereum network.

You'll need to go on **[https://iancoleman.io/bip39/](https://iancoleman.io/bip39/)** to retrieve your 12 Mnemonic keywords.

# Usage

To compile your smart contract with Solc-js:
```
node compile.js
```

To run the test cases with Mocha, Ganache-cli, and Web3.js:
```
cd test
npm test
```

To deploy your smart contract with truffle-hdwallet-provider and Infura.io:
```
node deploy.js
```

# Security

ALL SOURCE CODES SHOULD BE USED AS LEARNING MATERIAL ONLY.

## License

All source codes included in this repository are released under the [MIT License](LICENSE).
