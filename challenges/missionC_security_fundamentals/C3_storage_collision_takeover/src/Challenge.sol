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

contract LogicV1 {
    // slot 0 in logic -> collides with proxy.admin slot 0 under delegatecall
    uint256 public value;

    function setValue(uint256 v) external {
        value = v;
    }
}

contract Setup {
    SimpleProxy public proxy;
    LogicV1 public logic;

    constructor() payable {
        logic = new LogicV1();
        proxy = new SimpleProxy(address(logic));
    }

    function isSolved(address player) external view returns (bool) {
        return proxy.admin() == player;
    }
}