// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "forge-std/Test.sol";

import "./Token.sol";

contract test_solution is Test {
    Token level;
    address player = makeAddr("player");
    address player2 = makeAddr("player2");

    function setUp() public {
        Token _t = new Token(20);
        level = Token(_t);
        vm.deal(player, 1 ether);
    }

    function test_token_solution() public {
        vm.startPrank(player);
        level.transfer(player2, 213143); // any random value
        console.log("Balance of the player is now ", level.balanceOf(player));
    }
}
