// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Token.sol";

contract DEX {

    Token tokenA;
    address public tokenA_Address;

    Token tokenB;
    address public tokenB_Address;

    uint256 numerator;
    uint256 denominator;

    // Set max swap limit since these are for education purposes
    uint256 maxSwapLimit = 1000;

    constructor(address _tokenA, address _tokenB, uint256 _numerator, uint256 _denominator) {
        tokenA_Address = _tokenA;
        tokenA = Token(address(tokenA_Address));

        tokenB_Address = _tokenB;
        tokenB = Token(address(tokenB_Address));

        numerator = _numerator;
        denominator = _denominator;
    }

        // Get Token A to B ratio
    function getAToBRatio() public view returns (uint256) {
        return numerator / denominator;
    }

       // Swap token A for token B
    function swapAForB(uint _amount) public {
        require(tokenA.balanceOf(msg.sender) >= _amount, "You need more Token A");
        require(_amount > 0, "You need to sell at least some tokens");
        require(_amount <= maxSwapLimit, "You've exceeded the max swap limit!");
        uint256 approvedAmt = tokenA.allowance(msg.sender, address(this));
        require(approvedAmt >= _amount, "Check the token allowance");

        tokenA.transferFrom(msg.sender, address(this), _amount);
        tokenB.transfer(msg.sender, _amount / getAToBRatio());
    }

    // Swap token B for token A
    function swapBForA(uint _amount) public {
        require(tokenB.balanceOf(msg.sender) >= _amount, "You need more Token B");
        require(_amount > 0, "You need to sell at least some tokens");
        require(_amount <= maxSwapLimit, "You've exceeded the max swap limit!");
        uint256 approvedAmt = tokenB.allowance(msg.sender, address(this));
        require(approvedAmt >= _amount, "Check the token allowance");

        tokenA.transferFrom(msg.sender, address(this), _amount);
        tokenB.transfer(msg.sender, _amount * getAToBRatio());
    }
}