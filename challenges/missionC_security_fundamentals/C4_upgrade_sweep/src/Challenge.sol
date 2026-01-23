// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract SimpleProxy {
    // slot 0
    address public admin;
    // slot 1
    address public implementation;

    constructor(address impl) payable {
        admin = msg.sender;
        implementation = impl;
    }

    function upgradeTo(address newImpl) external {
        require(msg.sender == admin, "not admin");
        implementation = newImpl;
    }

    fallback() external payable {
        address impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let ok := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch ok
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    receive() external payable {}
}

// V1: harmlos, aber mit Storage-Kollision (slot0) -> überschreibt proxy.admin via delegatecall
contract LogicV1 {
    uint256 public value; // slot 0

    function setValue(uint256 v) external {
        value = v;
    }
}

// V2: “böse” Funktion, die nur nach Upgrade erreichbar ist
contract LogicV2 {
    // optional: gleiches Layout wie V1
    uint256 public value; // slot 0

    function sweep(address payable to) external {
    (bool sent,) = to.call{value: address(this).balance}("");
    require(sent, "send failed");
    }
}

contract Setup {
    SimpleProxy public proxy;
    LogicV1 public v1;

    uint256 public constant TREASURY = 10 ether;

    constructor() payable {
        require(msg.value == TREASURY, "need 10 ether");
        v1 = new LogicV1();
        proxy = new SimpleProxy{value: TREASURY}(address(v1));
    }

    function isSolved(address player) external view returns (bool) {
        // gelöst, wenn Proxy leer ist und Player mind. Treasury erhalten hat
        return address(proxy).balance == 0 && player.balance >= TREASURY;
    }
}