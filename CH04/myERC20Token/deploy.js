// Include all required modules
const contract = require('./compile.js');
const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');

// Unlike the test use cases, we're using a remote web3 provider
// with truffle-hdwallet-provider and Infura.io.
//
// Please go to https://iancoleman.io/bip39/ to retrieve your 12 keywords.
// !!! NEVER USE THE ACCOUNTS GENERATED AS REAL ACCOUNT !!!
var mnemonic = 'force lava party butter start seat second furnace pool proof orient before';
// Please go to https://infura.io/ to retrieve your access.
var URLProvider = 'https://ropsten.infura.io/2kJRCU4NxUH0KdpahsLo'; 

const provider = new HDWalletProvider(mnemonic, URLProvider);
var web3 = new Web3();
web3.setProvider(provider);

var contractName = 'MyERC20Token';

let accounts;
let myERC20Token;

// Set up here the argument of your smart contract called
// by the constructor.
const initArg = [10000, 'My ERC20 Token', 'MET', 2];

const deploy = async () => {
    try {
        accounts = await web3.eth.getAccounts();

        myERC20Token = await new web3.eth.Contract(contract[contractName].abi)
        // !!! CAREFUL !!! Starting from the 0.0.4 of truffle-hdwallet-provider, you need to add 'Ox'.
        // Otherwise, you'll be unable to process.
        // Please check on https://github.com/trufflesuite/truffle-hdwallet-provider/issues/33.
        .deploy({ data: '0x' + contract[contractName].evm.bytecode.object, arguments: initArg })
        .send({ from: accounts[0], gas: 2000000 });

        console.log('Contract Address:', myERC20Token.options.address);
    } catch(err) {
        console.log(err);
    }
};

deploy();
