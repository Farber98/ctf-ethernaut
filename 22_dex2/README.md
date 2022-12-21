# Requirements

- The goal of this level is for you to hack the basic DEX contract below and steal the funds by price manipulation.

- You need to drain all balances of token1 and token2 from the DexTwo contract to succeed in this level.

# Attack explanation

The vulnerability here arises from swap method which does not check that the swap is necessarily between token1 and token2. We'll exploit this by deploying another token and exchanging it for token 1 and token 2 in such wat to drain both from DextTwo. We'll need 300 from the other token and approve the contract to use them on our behalf.

We could solve the challenge by making the next calls:

- Send 100 EVL tokens so ratio between EVL and t1 is 1:1.

- Get token addresses:

```
m = "0xA1B6D558ea8ffb6dD689c0917470fb44C97E2aF5" // Malicious Token deployed
t1 = await contract.token1()
t2 = await contract.token2()
```

- Drain t1 with 100 tokens (ratio 1:1):

```
await contract.swap(m, t1, 100)
```

- Drain t2 with 200 tokens (ratio 1:2).

```
await contract.swap(m, t2, 200)
```
