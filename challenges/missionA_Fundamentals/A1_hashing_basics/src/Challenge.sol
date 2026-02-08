// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ChallengeA1 {
    // Simple deterministic hash for message signing later
    // NOTE: use abi.encode (not encodePacked) to avoid ambiguity.
    function hashMessage(
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline,
        uint256 chainId,
        address verifyingContract
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(to, amount, nonce, deadline, chainId, verifyingContract));
    }
}
