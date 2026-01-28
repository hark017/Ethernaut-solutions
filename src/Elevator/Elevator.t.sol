// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./Elevator.sol";

contract test_solution is Test {
    Elevator level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        Elevator _level = new Elevator();
        Solution _solution = new Solution();
        level = Elevator(_level);
        solution = Solution(_solution);

        vm.deal(player, 1 ether);
    }

    function test_elevator() public {
        vm.startPrank(player);
        solution.attack(address(level));
        assertEq(true, level.top());
        vm.stopPrank();
    }
}
