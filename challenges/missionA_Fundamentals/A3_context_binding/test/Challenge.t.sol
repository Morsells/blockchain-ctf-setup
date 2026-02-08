// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/Challenge.sol";

contract ChallengeA3Clone is ChallengeA3 {}

contract ChallengeA3Test is Test {
    function test_A3_context_binding_blocks_clone_and_chain_replay() public {
        uint256 pk = 0xB0B;
        address from = vm.addr(pk);
        address to = address(0xBEEF);
        uint256 amount = 10;
        uint256 nonce = 0;
        uint256 deadline = block.timestamp + 1 days;

        // Same chainId, two different contracts -> digest differs
        ChallengeA3 c1 = new ChallengeA3();
        ChallengeA3 c2 = new ChallengeA3();

        bytes32 d1 = c1.digest(from, to, amount, nonce, deadline);
        bytes32 d2 = c2.digest(from, to, amount, nonce, deadline);

        assertTrue(d1 != d2, "Digest must include address(this)");

        // chainId binding
        vm.chainId(999);
        bytes32 dChain999 = c1.digest(from, to, amount, nonce, deadline);

        vm.chainId(31337);
        bytes32 dChain31337 = c1.digest(from, to, amount, nonce, deadline);

        assertTrue(dChain999 != dChain31337, "Digest must include chainId");

        emit log_string("FLAG{A3_CONTEXT_OK_5a2b0f11}");
    }
}
