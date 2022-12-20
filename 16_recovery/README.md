# Requirements

- Recover lost funds from missing address.

# Attack explanation

Steps to solve:

1. Check your instance transaction to find contract creation.
2. When you find the token contract address, transfer some funds as it will multiply your balance by ten.
3. Selfdestruct the contract to your own address to recover some eth.
