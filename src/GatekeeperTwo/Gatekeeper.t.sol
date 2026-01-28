// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./GatekeeperTwo.sol";

contract test_solution is Test {
    GatekeeperTwo level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        GatekeeperTwo _level = new GatekeeperTwo();
        Solution _solution = new Solution(address(_level));
        level = GatekeeperTwo(_level);
        solution = Solution(_solution);
        vm.deal(player, 1 ether);
    }

    function test_gatekeepertwo() public {
        console.log("the entrant now", level.entrant());
        assertEq(level.entrant(), 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    }
}
