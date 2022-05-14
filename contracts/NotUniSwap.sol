// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./TokenA.sol";
import "./TokenB.sol";

contract NotUniSwap {

    TokenA tokenA;
    address public tokenA_Address;

    TokenB tokenB;
    address public tokenB_Address;



    constructor(address _tokenA, address _tokenB) {
        tokenA_Address = _tokenA;
        tokenA = TokenA(address(tokenA_Address));

        tokenB_Address = _tokenB;
        tokenB = TokenB(address(tokenB_Address));
    }

        // Get Token A to B ratio
        function getAToBRatio() public pure returns (uint256) {
            uint256 numerator = 10;
        uint256 denominator = 18;
        return numerator / denominator;
    }

       // Swap token A for token B
    function swapAForB(uint _amount) public {
        require(tokenA.balanceOf(msg.sender) >= _amount, "You need more Token A");
        require(_amount > 0, "You need to sell at least some tokens");
        uint256 approvedAmt = tokenA.allowance(msg.sender, address(this));
        require(approvedAmt >= _amount, "Check the token allowance");

        tokenA.transferFrom(msg.sender, address(this), _amount);
        tokenB.transfer(msg.sender, _amount / getAToBRatio());
    }

    // Swap token B for token A
    function swapBForA(uint _amount) public {
        require(tokenB.balanceOf(msg.sender) >= _amount, "You need more Token B");
        require(_amount > 0, "You need to sell at least some tokens");
        uint256 approvedAmt = tokenB.allowance(msg.sender, address(this));
        require(approvedAmt >= _amount, "Check the token allowance");

        tokenA.transferFrom(msg.sender, address(this), _amount);
        tokenB.transfer(msg.sender, _amount * getAToBRatio());
    }
}