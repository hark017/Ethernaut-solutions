// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./King.sol";

contract test_solution is Test {
    Solution solution;
    King _king;
    address player = makeAddr("player");
    address player1 = makeAddr("player1");

    function setUp() public {
        vm.deal(player1, 100 ether);
        vm.startPrank(player1);
        solution = Solution(new Solution());
        _king = King(new King{value: 0.1 ether}());
        vm.stopPrank();
        vm.deal(player, 100 ether);
        vm.deal(address(this), 100 ether);
    }

    function test_king() public {
        assertEq(_king.owner(), player1);
        console.log("Current King :", _king._king(), "address of this is ", player1);
        vm.startPrank(player);
        solution.attack{value: 1 ether}(payable(address(_king)));
        console.log("Current King :", _king._king(), "and current prize is: ", _king.prize());
        vm.stopPrank();
        vm.startPrank(player1); // because he is the owner
        vm.expectRevert(bytes("sorry buddy, I got you!"));
        (bool success,) = address(_king).call{value: 1 wei}("");
        vm.stopPrank();
    }
}
