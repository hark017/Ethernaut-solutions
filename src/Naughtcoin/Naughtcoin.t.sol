// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Naughtcoin.sol";

contract test_solution is Test {
    NaughtCoin level;
    address player = makeAddr("player");
    address player2 = makeAddr("player2");

    function setUp() public {
        NaughtCoin _level = new NaughtCoin(player);
        level = NaughtCoin(_level);
        vm.deal(player, 1 ether);
        vm.deal(player2, 1 ether);
    }

    function test_naughtcoin() public {
        console.log("Balance of player initially", level.balanceOf(player));
        vm.startPrank(player);
        level.approve(player2, type(uint256).max);
        vm.stopPrank();

        vm.startPrank(player2);
        level.transferFrom(player, player2, 1000000 * (10 ** 18));
        vm.stopPrank();

        console.log("balance of player", level.balanceOf(player));
        console.log("balance of the player2 now", level.balanceOf(player2));
    }
}
