// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./Reentrance.sol";

contract test_solution is Test {
    Reentrance level;
    Solution solution;
    address player = makeAddr("player");
    address user = makeAddr("user");

    function setUp() public {
        Reentrance _level = new Reentrance();
        Solution _solution = new Solution();
        level = Reentrance(_level);
        solution = Solution(_solution);
        vm.deal(player, 1 ether);
        vm.deal(user, 1 ether);
    }

    function test_reentrance() public {
        vm.startPrank(user);
        level.donate{value: 0.5 ether}(user);
        vm.stopPrank();

        console.log("current balance", address(level).balance);
        vm.startPrank(player);
        solution.set_target(payable(address(level)), address(level).balance);
        level.donate{value: 0.05 ether}(address(solution));
        solution.attack();
        vm.stopPrank();

        assertEq(0, address(level).balance);
    }
}
