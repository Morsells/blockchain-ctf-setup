// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";

contract ChallengeA4Test is Test {
    function test_A4_nonce_and_deadline() public {
        ChallengeA4 c = new ChallengeA4();
        address signer = address(0xA11CE);

        uint256 deadline = block.timestamp + 100;

        // First consume ok
        c.validateAndConsume(signer, 0, deadline);
        assertEq(c.nonces(signer), 1);

        // Replay should fail
        vm.expectRevert(ChallengeA4.BadNonce.selector);
        c.validateAndConsume(signer, 0, deadline);

        // Expired should fail
        vm.warp(block.timestamp + 200);
        vm.expectRevert(ChallengeA4.Expired.selector);
        c.validateAndConsume(signer, 1, deadline);

        emit log_string("FLAG{A4_NONCE_OK_2c9d44aa}");
    }
}
