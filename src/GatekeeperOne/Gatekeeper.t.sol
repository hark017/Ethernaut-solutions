// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./GatekeeperOne.sol";

contract test_solution is Test {
    GatekeeperOne level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        GatekeeperOne _level = new GatekeeperOne();
        Solution _solution = new Solution();
        level = GatekeeperOne(_level);
        solution = Solution(_solution);

        vm.deal(player, 1 ether);
    }

    function test_gatekeeperone() public {
        vm.startPrank(player);
        solution.the_txori();
        solution.attack(address(level));
        assertEq(level.entrant(), 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38); // the tx.origin in our test environment
        vm.stopPrank();
    }
}
