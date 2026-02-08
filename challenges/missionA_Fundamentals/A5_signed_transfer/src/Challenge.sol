// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ChallengeA5 {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public nonces;

    error Expired();
    error BadNonce();
    error BadSig();
    error InsufficientBalance();
    error BadSigLength();

    bytes32 public constant TYPEHASH =
        keccak256("SignedTransfer(address from,address to,uint256 amount,uint256 nonce,uint256 deadline,uint256 chainId,address verifyingContract)");

    event Executed(address indexed from, address indexed to, uint256 amount, uint256 nonce);

    function mintForTraining(address user, uint256 amount) public {
        // For challenge simplicity. In real world: restricted.
        balances[user] += amount;
    }

    function digest(
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline
    ) public view returns (bytes32) {
        bytes32 sh = keccak256(abi.encode(
            TYPEHASH,
            from,
            to,
            amount,
            nonce,
            deadline,
            block.chainid,
            address(this)
        ));
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", sh));
    }

    function recoverSigner(bytes32 dgst, bytes memory signature) public pure returns (address) {
        if (signature.length != 65) revert BadSigLength();

        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }
        if (v < 27) v += 27;

        return ecrecover(dgst, v, r, s);
    }

    function executeSignedTransfer(
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline,
        bytes calldata signature
    ) external {
        if (block.timestamp > deadline) revert Expired();
        if (nonces[from] != nonce) revert BadNonce();

        bytes32 dgst = digest(from, to, amount, nonce, deadline);
        address signer = recoverSigner(dgst, signature);
        if (signer != from) revert BadSig();

        if (balances[from] < amount) revert InsufficientBalance();

        // Effects
        nonces[from] = nonce + 1;

        // State update
        balances[from] -= amount;
        balances[to] += amount;

        emit Executed(from, to, amount, nonce);
    }
}
