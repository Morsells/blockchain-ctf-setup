// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";

contract ChallengeA5Test is Test {
    function test_A5_signed_transfer_happy_and_replay_protection() public {
        ChallengeA5 c = new ChallengeA5();

        uint256 pk = 0xA11CE;
        address from = vm.addr(pk);
        address to = address(0xBEEF);

        c.mintForTraining(from, 100);

        uint256 amount = 25;
        uint256 nonce = 0;
        uint256 deadline = block.timestamp + 1 days;

        bytes32 dgst = c.digest(from, to, amount, nonce, deadline);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, dgst);
        bytes memory sig = abi.encodePacked(r, s, v);

        // success once
        c.executeSignedTransfer(from, to, amount, nonce, deadline, sig);
        assertEq(c.balances(from), 75);
        assertEq(c.balances(to), 25);

        // replay must fail (nonce advanced)
        vm.expectRevert(ChallengeA5.BadNonce.selector);
        c.executeSignedTransfer(from, to, amount, nonce, deadline, sig);

        // tamper amount must fail
        uint256 nonce2 = c.nonces(from);
        bytes32 dgst2 = c.digest(from, to, 99, nonce2, deadline);
        (v, r, s) = vm.sign(pk, dgst2);
        sig = abi.encodePacked(r, s, v);

        // Use wrong params with a signature for different amount => BadSig
        vm.expectRevert(ChallengeA5.BadSig.selector);
        c.executeSignedTransfer(from, to, 25, nonce2, deadline, sig);

        emit log_string("FLAG{A5_SIGNED_TRANSFER_OK_4d1e7aa9}");
    }
}
