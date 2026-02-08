// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";

contract ChallengeA2Test is Test {
    function test_A2_recover_signer() public {
        ChallengeA2 c = new ChallengeA2();

        uint256 pk = 0xA11CE;
        address signer = vm.addr(pk);

        bytes32 digest = keccak256("hello");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, digest);
        bytes memory sig = abi.encodePacked(r, s, v);

        address got = c.recoverSigner(digest, sig);
        assertEq(got, signer, "Recovered signer mismatch");

        emit log_string("FLAG{A2_RECOVER_OK_19c7d8b4}");
    }
}
