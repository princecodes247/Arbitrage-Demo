// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Token.sol";
import "./DEX_Interface.sol"
contract Arbitrage {

    Token tokenA;
    address public tokenA_Address;
    Token tokenB;
    address public tokenB_Address;

    DEX_Interface dex1;
    address public dex1_Address;
    DEX_Interface dex2;
    address public dex2_Address;
    constructor(address DEX1, address DEX2, address _tokenA, address _tokenB) {
        tokenA = Token(_tokenA);
        tokenB = Token(_tokenB);
        dex1 = DEX_Interface(DEX1);
        dex2 = DEX_Interface(DEX2);
    }

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
        
        require(tokenA.balanceOf(msg.sender) >= _amount, "You need more Token A");
        require(_amount > 0, "You need to sell at least some tokens");
        // require(_amount <= maxSwapLimit, "You've exceeded the max swap limit!");
        uint256 approvedAmt = tokenA.allowance(msg.sender, address(this));
        require(approvedAmt >= _amount, "Check the token allowance");

        tokenA.transferFrom(msg.sender, address(this), _amount);
        dex1.swapAForB(_amount);
        dex2.swapBForA(_amount);
    }
}
