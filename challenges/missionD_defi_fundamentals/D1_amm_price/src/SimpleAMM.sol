// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Minimaler AMM mit konstantem Produkt (x*y=k) inkl. Fee
contract SimpleAMM {
    uint256 public constant BPS = 10_000;
    uint256 public constant FEE_BPS = 30;

    uint256 public reserveA;
    uint256 public reserveB;

    event Swap(address indexed from, bool aToB, uint256 amountIn, uint256 amountOut);

    constructor(uint256 _a, uint256 _b) {
        reserveA = _a;
        reserveB = _b;
    }

    // A-Preis in B (18 Dezimalstellen)
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

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) public pure returns (uint256) {
        require(amountOut > 0, "bad out");
        require(reserveIn > 0 && reserveOut > amountOut, "bad reserve");

        uint256 numer = reserveIn * amountOut * BPS;
        uint256 denom = (reserveOut - amountOut) * (BPS - FEE_BPS);
        return (numer / denom) + 1;
    }

    function swapAforB(uint256 amountIn) external returns (uint256 out) {
        out = getAmountOut(amountIn, reserveA, reserveB);
        reserveA += amountIn;
        reserveB -= out;
        emit Swap(msg.sender, true, amountIn, out);
    }

    function swapBforA(uint256 amountIn) external returns (uint256 out) {
        out = getAmountOut(amountIn, reserveB, reserveA);
        reserveB += amountIn;
        reserveA -= out;
        emit Swap(msg.sender, false, amountIn, out);
    }
}

