pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
  string public name = "EthSwap Instant Exchange";
  // here token variable represents the Token smart contract 
  Token public token;
  uint public rate = 100;

  event TokenPurchased(
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

    // Require that Ethswap has enough tokens
    require(token.balanceOf(address(this)) >= tokenAmount);

    // transfer token to the user
    token.transfer(msg.sender, tokenAmount);
    
    // emit an event
    emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
  }

}