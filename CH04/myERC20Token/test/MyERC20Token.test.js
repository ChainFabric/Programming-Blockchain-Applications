require('events').EventEmitter.defaultMaxListeners = 20;

// Include all required modules
const contract = require('../compile.js');
const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');

// You need to set a provider when you create a web3 instance.
// It could be Mist, MetaMask, in your localhost or remotely.
// In our case, we want to use Ganache as provider.
// More information are available on their documentation.
// Please check on https://github.com/trufflesuite/ganache-cli.
var web3 = new Web3();
web3.setProvider(ganache.provider());

var contractName = 'MyERC20Token';

let accounts;
let myERC20Token;

// Set up here the argument of your smart contract called
// by the constructor.
const initArg = [10000, 'My ERC20 Token', 'MET', 2];

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();

    myERC20Token = await new web3.eth.Contract(contract[contractName].abi)
    .deploy({ data: contract[contractName].evm.bytecode.object, arguments: initArg })
    .send({ from: accounts[0], gas: 2000000 });
});

// Here, a imple test to check if our ganache was instanciated properly.
// By default, ganache set up 10 accounts. If all is set up properly,
// you'll see a list of account's addresses.
describe('TEST GANACHE', () => {
    it('Check if ganache is working.', () => {
        console.log('List of all accounts created by Ganache:\n', accounts);
    });
});

// Here, we created a few basic cases to test the behivior of our
// smart contract. Nothing fanzy but that should give a pretty
// good idea on how we can create test use case with Mocha.
// More information are available on https://mochajs.org/.
describe('TEST CONTRACT', () => {
    it('Check if the contract has been compiled and deployed.', () => {
        assert.ok(myERC20Token.options.address);
        console.log('Address of my contract:', myERC20Token.options.address);
    });

    it('Check if the method transfer behaves as expected.', async () => {
        let balance;

        const transferValue = 100; 
        const transfer = await myERC20Token.methods
        .transfer(accounts[1], transferValue).send({ from: accounts[0] });

        balance = await myERC20Token.methods
        .balanceOf(accounts[1]).call();
        assert.equal(
            balance,
            transferValue,
            'The balance of the account ' + accounts[1] + ' is wrong.'
        );
    });

    it('Check if the methods approve, allowance, and transferFrom behaves as expected.', async () => {
        let balance;
        let remainingInitial;
        let remainingFinal;

        const approveValue = 100;
        const approve = await myERC20Token.methods
        .approve(accounts[1], approveValue).send({ from: accounts[0] });

        remainingInitial = await myERC20Token.methods
        .allowance(accounts[0], accounts[1]).call();
        assert.equal(
            remainingInitial,
            approveValue,
            'The allowance value from the account ' + accounts[0] + ' to ' + accounts[1] + ' is wrong.'
        );

        const transferFromValue = 10;
        const transferFrom = await myERC20Token.methods
        .transferFrom(accounts[0], accounts[1], transferFromValue).send({ from: accounts[1] });

        balance = await myERC20Token.methods
        .balanceOf(accounts[1]).call();
        assert.equal(
            balance,
            transferFromValue,
            'The balance of the account ' + accounts[1] + ' is wrong.'
        );

        remainingFinal = await myERC20Token.methods
        .allowance(accounts[0], accounts[1]).call();
        assert.equal(
            remainingFinal,
            remainingInitial-transferFromValue,
            'The allowance value from the account ' + accounts[0] + ' to ' + accounts[1] + ' is wrong.'
        );
    });
});
