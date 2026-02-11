// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Challenge.sol";

contract Solution {
    function solve(Setup setup) external {
        UserRegistry registry = setup.registry();
        
        // TODO: Registriere dich als User
        
        // TODO: Werde Admin mit dem Bug in becomeAdmin()
        
        // TODO: Hebe Geld ab (nur Admins können withdrawen)
        
        // TODO: Überprüfe dass du jetzt Admin bist und Balance > 0 hast
    }
}