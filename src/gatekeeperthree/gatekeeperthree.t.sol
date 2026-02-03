// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./gatekeeperthree.sol";

contract test_solution is Test {
    GatekeeperThree level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        level = new GatekeeperThree();
        level.createTrick();
        solution = new Solution(payable(address(level)));
        vm.deal(player, 1 ether);
    }

    function test_gatekeeperthree() public {
        bytes32 slot2 = vm.load(address(level.trick()), bytes32(uint256(2))); // as we can always read from the blockchain, it doesn't matter if the variable is private or public
        uint256 pasword = uint256(slot2);

        vm.startPrank(player, player);
        solution.myreceive{value: 0.5 ether}();
        solution.attack(pasword);
        assertEq(level.entrant(), player);
        vm.stopPrank();
    }
}
