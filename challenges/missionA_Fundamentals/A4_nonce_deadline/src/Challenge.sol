// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ChallengeA4 {
    mapping(address => uint256) public nonces;

    error Expired();
    error BadNonce();

    function validateAndConsume(address signer, uint256 nonce, uint256 deadline) public {
        if (block.timestamp > deadline) revert Expired();
        if (nonces[signer] != nonce) revert BadNonce();
        nonces[signer] = nonce + 1;
    }
}
