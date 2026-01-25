// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./SimpleToken.sol";

/**
 * @title Challenge Interface
 * @dev Definiert die erforderlichen Funktionen für den SecureVault
 */
interface IChallenge {
    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;
    function getVaultBalance() external view returns (uint256);
    function getUserBalance(address user) external view returns (uint256);
    function pause() external;
    function unpause() external;
    function owner() external view returns (address);
    function token() external view returns (SimpleToken);
    function paused() external view returns (bool);
}