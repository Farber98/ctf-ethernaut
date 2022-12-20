// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperProxy {
    constructor(address _addr) {
        bytes8 bytesKeccak = bytes8(keccak256(abi.encodePacked(address(this))));
        uint64 uintBytesKeccak = uint64(bytesKeccak);
        uint64 theKey = uintBytesKeccak ^ type(uint64).max;
        _addr.call(abi.encodeWithSignature("enter(bytes8)", bytes8(theKey)));
    }
}
