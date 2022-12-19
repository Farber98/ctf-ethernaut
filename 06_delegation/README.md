# Requirements

- Claim ownership of the contract.

# Attack explanation

delegatecall is a low level function that executes callee code within caller context. For using delegate call, you must keep in mind next two things:

1. delegate call preserves caller context.
2. storage layout must be the same for caller and callee.

For claiming ownership of this contract, we can exploit a vulnerability in the Delegation contract. Fallback function is making an unsafe delegatecall to an external library, because it is passing msg.data.

```
fallback() external {
  (bool result,) = address(delegate).delegatecall(msg.data);
  if (result) {
    this;
  }
}
```

In this way, we could pass a function selector as msg.data to execute pwn external function. This will set the new owner to msg.sender, but wait, remember delegate call preserves caller context, so this will set the owner of Delegation, our base contract!

```
function pwn() public {
  owner = msg.sender;
}
```

# Attack function

We could solve the challenge by just using the following attack function:

```
function attack() public {
    vulnerableContract.call(abi.encodeWithSignature("pwn()"));
}
```

In order to solve the challenge, we need to pass sendTransaction({from: player, to: instance, data: "0xdd365b8b"}), where data is pwn function selector.
