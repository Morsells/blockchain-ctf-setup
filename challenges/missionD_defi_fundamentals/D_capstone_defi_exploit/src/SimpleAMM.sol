// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./TokenA.sol";
import "./TokenB.sol";

contract SimpleAMM {
    uint256 public constant BPS = 10_000;
    uint256 public constant FEE_BPS = 30;

    TokenA public tokenA;
    TokenB public tokenB;
    uint256 public reserveA;
    uint256 public reserveB;

    constructor(TokenA _a, TokenB _b, uint256 initA, uint256 initB) {
        tokenA = _a;
        tokenB = _b;
        tokenA.mintForTraining(address(this), initA);
        tokenB.mintForTraining(address(this), initB);
        reserveA = initA;
        reserveB = initB;
    }

    function spotPriceAinB() external view returns (uint256) {
        require(reserveA > 0, "no A");
        return (reserveB * 1e18) / reserveA;
    }

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) public pure returns (uint256) {
        uint256 amountInWithFee = (amountIn * (BPS - FEE_BPS)) / BPS;
        return (amountInWithFee * reserveOut) / (reserveIn + amountInWithFee);
    }

    function swapBforA(uint256 amountIn) external returns (uint256 out) {
        require(tokenB.transferFrom(msg.sender, address(this), amountIn), "b in");
        out = getAmountOut(amountIn, reserveB, reserveA);
        reserveB += amountIn;
        reserveA -= out;
        require(tokenA.transfer(msg.sender, out), "a out");
    }

    function swapAforB(uint256 amountIn) external returns (uint256 out) {
        require(tokenA.transferFrom(msg.sender, address(this), amountIn), "a in");
        out = getAmountOut(amountIn, reserveA, reserveB);
        reserveA += amountIn;
        reserveB -= out;
        require(tokenB.transfer(msg.sender, out), "b out");
    }
}

