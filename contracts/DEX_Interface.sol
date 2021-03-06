// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface DEX_INTERFACE {
    /**
     * @dev Get Token A to B ratio
     */
    function getAToBRatio() external view returns (uint256);

    /**
     * @dev Swap token A for token B
     * @param _amount Amount of token A to swap
     */
    function swapAForB(uint256 _amount) external;

    /**
     * @dev Swap token B for token A
     * @param _amount Amount of token B to swap
     */
    function swapBForA(uint256 _amount) external;
}