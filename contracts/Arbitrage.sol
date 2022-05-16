// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Token.sol";

contract Arbitrage {

    Token tokenA;
    address public tokenA_Address;

    constructor(address DEX1, address DEX2) {}

    // Fund Contract with Token A
    function fundContract(uint256 _amount) public {
        require(tokenA.balanceOf(msg.sender) >= _amount, "You need more Token A");
        require(_amount > 0, "You need to sell at least some tokens");
        // require(_amount <= maxSwapLimit, "You've exceeded the max swap limit!");
        uint256 approvedAmt = tokenA.allowance(msg.sender, address(this));
        require(approvedAmt >= _amount, "Check the token allowance");

        tokenA.transferFrom(msg.sender, address(this), _amount);
    }

    // Swap token A for token B
    function performArbitrage(uint256 _amount) public {
        
    }
}
