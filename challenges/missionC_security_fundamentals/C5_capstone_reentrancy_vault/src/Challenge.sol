@'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Setup {
    function isSolved(address /*player*/) external pure returns (bool) {
        return false;
    }
}
'@ | Set-Content -Encoding UTF8 "templates\foundry-challenge-template\src\Challenge.sol"