// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./GoodSamaritan.sol";
import "forge-std/Test.sol";

import "./Solution.sol";

contract test_solution is Test {
    GoodSamaritan level;
    Solution solution;
    Coin coin;
    address player = makeAddr("player");

    function setUp() public {
        level = new GoodSamaritan();
        solution = new Solution(address(level));
        coin = level.coin();
        vm.deal(player, 1 ether);
    }

    function test_goodsamaritan() public {
        console.log("the initial balance of the wallet is : ", coin.balances(address(level.wallet())));
        vm.startPrank(player);
        solution.attack();
        console.log("the final balance of the wallet is : ", coin.balances(address(level.wallet())));
        vm.stopPrank();
    }
}

