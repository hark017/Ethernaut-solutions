// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Solution.sol";
import "./Force.sol";

import "forge-std/Test.sol";

contract test_solution is Test {
    Force level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        Force _level = new Force();
        Solution _solution = new Solution();

        level = Force(_level);
        solution = Solution(_solution);

        vm.deal(player, 1 ether);
    }

    function test_force() public {
        vm.startPrank(player);
        solution.destroy{value: 0.1 ether}(address(level));
        assertEq(address(level).balance, 0.1 ether);
        console.log("balance of the Force contract is now : ", address(level).balance);
    }
}
