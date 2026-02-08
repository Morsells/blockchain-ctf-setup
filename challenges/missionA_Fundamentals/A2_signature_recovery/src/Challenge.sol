// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ChallengeA2 {
    error BadSigLength();

    function recoverSigner(bytes32 digest, bytes memory signature) public pure returns (address) {
        if (signature.length != 65) revert BadSigLength();

        bytes32 r;
        bytes32 s;
        uint8 v;

        // signature layout: r(32) | s(32) | v(1)
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        // normalize v if needed
        if (v < 27) v += 27;

        return ecrecover(digest, v, r, s);
    }
}
