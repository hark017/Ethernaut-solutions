// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./Telephone.sol";

contract test_solution is Test {
    Telephone level;
    Solution _solution;
    address player = makeAddr("player");

    function setUp() public {
        Telephone _telephone = new Telephone();
        level = Telephone(_telephone);
        Solution solution = new Solution();
        _solution = Solution(solution);
        vm.deal(player, 1 ether);
    }

    function test_telephone() public {
        vm.startPrank(player);
        console.log("The initial owner is ", level.owner());
        _solution.attack(address(level));
        console.log("The final owner is ", level.owner());
        assertEq(level.owner(), player, "PLayer is not the owner as of now.");
    }
}
