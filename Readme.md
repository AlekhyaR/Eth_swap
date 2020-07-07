Ganache - Is personal Ethereum Blockchain which can use to run tests, execute commands, and inspect state while controlling how the chain operates

Truffle - Smart Contract development framework. It allows us to develop Ethereum smart contracts with solidity programming language. write tests for them in javascript and deploy them to blockchain.

Metamask - Helps in connecting your web browser to blockchain 

Migrations - Migration files are used to deploy the smart contracts to the blockchain 

package.json - This file tracks all project dependencies as well as other NPM Settings

contract EthSwap {
  string public name = "EthSwap Instant Exchange";
}

Now let's interact with our smart contract in the development console and see if the name was set properly. In order to do this we must first add this smart contract to the blockchain ==> This requires us to create migration file like this 
touch migrations/2_deploy_contracts.js

Running test cases: truffle test 

Truffle console 
truffle compile gets run even before the test suit will run  


Reference Article 
https://www.dappuniversity.com/articles/learn-blockchain

video link 
https://www.youtube.com/watch?v=99pYGpTWcXM

