pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
  string public name = "EthSwap Instant Exchange";
  // here token variable represents the Token smart contract 
  Token public token;
  uint public rate = 100;

  event TokensPurchased(
    address account,
    address token, 
    uint amount,
    uint rate
  );

  event TokensSold(
    address account,
    address token, 
    uint amount,
    uint rate
  );

  // who purchased the token
  // token that was purchased
  // amount of tokens that were purchased
  // rate - redumption rate the rate at which they purchased token with
  // we must provide --------------- the Token smart contract address to EthSwap
  constructor(Token _token) public {
      token = _token;
  }
  //transfer tokens from ethswap contract to the person who is buying them
  // msg is global variable inside we have sender as a method  => where the token is going to (is msg.sender)
  function buyTokens() public payable {
    // here payable plays a role of buying the ether without this payable keyword you can't procced to buy 
    // Redemption rate = # of tokens they receive for 1 ether
    // Amount of Ethereum * Redemption rate
    // calculate number of token to buy
    uint tokenAmount = msg.value * rate;

    
    require(token.balanceOf(address(this)) >= tokenAmount); // Require that Ethswap has enough tokens

    
    token.transfer(msg.sender, tokenAmount); // transfer token to the user
    
    
    emit TokensPurchased(msg.sender, address(token), tokenAmount, rate); // emit an event
  }

  
  function sellTokens(uint _amount) public {  // transfer the tokens from investor to ethswap exchange 
    // user can't sell the ethers more than they have
    require(token.balanceOf(msg.sender) >= _amount);
    
    uint etherAmount = _amount / rate; // calculate the amount of ether to redeem
    
    require(address(this).balance >= etherAmount); // require that etherSwap has enough ether 

    token.transferFrom(msg.sender, address(this), _amount); // perform sale
    msg.sender.transfer(etherAmount);
    emit TokensSold(msg.sender, address(token), _amount, rate); // emit an event
  }


}