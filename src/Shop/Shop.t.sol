// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./Shop.sol";

contract test_solution is Test {
    Shop level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        level = new Shop();
        solution = new Solution(address(level));
        vm.deal(player, 1 ether);
    }

    function test_shop() public {
        vm.startPrank(player);
        solution.buy();
        assertEq(level.price(), 1); // sold at very lower price compared to 100
        vm.stopPrank();
    }
}
