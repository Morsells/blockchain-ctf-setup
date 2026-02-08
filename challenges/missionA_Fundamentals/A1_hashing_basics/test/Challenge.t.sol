// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";

contract ChallengeA1Test is Test {
    function test_A1_hashing_is_deterministic_and_correct() public {
        ChallengeA1 c = new ChallengeA1();

        address to = address(0xBEEF);
        uint256 amount = 123;
        uint256 nonce = 7;
        uint256 deadline = 999999;
        uint256 chainId = 31337;
        address verifying = address(0xCAFE);

        bytes32 got = c.hashMessage(to, amount, nonce, deadline, chainId, verifying);
        bytes32 expected = keccak256(abi.encode(to, amount, nonce, deadline, chainId, verifying));

        assertEq(got, expected, "Hash mismatch (must use abi.encode)");

        // determinism
        assertEq(got, c.hashMessage(to, amount, nonce, deadline, chainId, verifying), "Not deterministic");

        emit log_string("FLAG{A1_HASHING_OK_8f3c2a1d}");
    }
}
