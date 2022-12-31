# Requirements

- The goal of this level is for you to claim ownership of the instance you are given.

# Attack explanation

The vulnerability here arises from using delegatecall between two contracts that have different storage layout. If execute storedTime in LibraryContract with delegatecall, we will be modifying slot 0 from caller contract (Preservation). In other words, we will be setting timeZone1Library to a desired address.

If we set that desired address to another malicious smart contract that we own, we could define a storage layout there that allow us to modify Preservation contract owner storage variable with a delegatecall (slot 3).
