// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address public attacker;

    constructor() {
        attacker = msg.sender;
    }

    // Receive function that consumes all gas.
    receive() external payable {
        while (gasleft() > 0) {}
    }
}
