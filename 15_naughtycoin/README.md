# Requirements

- Make it past the gatekeeper and register as an entrant to pass this level.

# Attack explanation

Because NaughtCoin is an ERC20 token, we could bypass the player lock by giving allowance to another EOA to spend that tokens in behalf of the owner. In this way, we could transfer that tokens from the contract to the other EOA.

```
// Prevent the initial owner from transferring tokens until the timelock has passed
modifier lockTokens() {
    if (msg.sender == player) { // Only prevents that player.
        require(block.timestamp > timeLock);
        _;
    } else {
        _;
    }
}
```

Steps to solve:

1. Give allowance to spend total supply to another EOA.
2. Make the other EOA transfer from all the funds.
