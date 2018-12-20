// Include all required modules
const solc = require('solc');
const path = require('path');
const fs = require('fs');

// Retrieve the source code of our smart contract
const contractPath = path.resolve(__dirname, 'contracts', 'MyERC20Token.sol');
const source = fs.readFileSync(contractPath, 'utf8');

// Compile our smart contract with Solc-js and let other module to import the result.
// Be aware of the compiler version set by default in your Solc-js version.
// Solc-js let you to set a specific version of the compiler if needed.
// Please check the Solc-js documentation on https://github.com/ethereum/solc-js.
var input = {
    language: 'Solidity',
    sources: {
        'MyERC20Token.sol': {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': [ '*' ]
            }
        }
    }
};

// You can uncomment this part of the code and run the command ```node compile.js```
// to see the result of the compiler. Here, we display the bytecode value of our
// smart contract.
//
// var output = JSON.parse(solc.compile(JSON.stringify(input)));
// 
// for (var contractName in output.contracts['MyERC20Token.sol']) {
//     console.log(contractName + ': ' + output.contracts['MyERC20Token.sol'][contractName].evm.bytecode.object);
// }

module.exports = JSON.parse(solc.compile(JSON.stringify(input))).contracts['MyERC20Token.sol'];
