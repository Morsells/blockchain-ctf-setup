// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ChallengeA3 {
    bytes32 public constant TYPEHASH =
        keccak256("SignedTransfer(address from,address to,uint256 amount,uint256 nonce,uint256 deadline,uint256 chainId,address verifyingContract)");

    function structHash(
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline
    ) public view returns (bytes32) {
        return keccak256(abi.encode(
            TYPEHASH,
            from,
            to,
            amount,
            nonce,
            deadline,
            block.chainid,
            address(this)
        ));
    }

    function digest(
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline
    ) public view returns (bytes32) {
        bytes32 sh = structHash(from, to, amount, nonce, deadline);
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", sh));
    }
}
