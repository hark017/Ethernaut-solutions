// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GatekeeperTwo.sol";

contract Solution {
    constructor(address _target) {
        GatekeeperTwo target = GatekeeperTwo(_target);
        bytes8 _gatekey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
        target.enter(_gatekey);
    }
}
