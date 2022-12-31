// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaliciousContract {
    uint256 somevar1;
    uint256 somevar2;
    uint256 owner;

    function setTime(uint256 _time) public {
        owner = _time;
    }
}
