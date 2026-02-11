// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// AMM mit konstantem Produkt + Fee
contract SimpleAMM {
    uint256 public constant BPS = 10_000;
    uint256 public constant FEE_BPS = 30;

    uint256 public reserveA;
    uint256 public reserveB;

    constructor(uint256 _a, uint256 _b) {
        reserveA = _a;
        reserveB = _b;
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
        require(amountIn > 0, "bad in");
        require(reserveIn > 0 && reserveOut > 0, "bad reserve");

        uint256 amountInWithFee = (amountIn * (BPS - FEE_BPS)) / BPS;
        return (amountInWithFee * reserveOut) / (reserveIn + amountInWithFee);
    }

    function swapBforA(uint256 amountIn) external returns (uint256 out) {
        out = getAmountOut(amountIn, reserveB, reserveA);
        reserveB += amountIn;
        reserveA -= out;
    }

    function swapAforB(uint256 amountIn) external returns (uint256 out) {
        out = getAmountOut(amountIn, reserveA, reserveB);
        reserveA += amountIn;
        reserveB -= out;
    }
}

