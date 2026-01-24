// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "./CoinFlip.sol";
import "./Solution.sol";

contract test_coinFlip is Test{
    CoinFlip level;
    Solution solution;
    address player = makeAddr("player");
    address originalOwner;

    function setUp() public {
        CoinFlip target_address = new CoinFlip();
        level = CoinFlip(target_address);
        Solution Solution_address = new Solution();
        solution = Solution(Solution_address);
        vm.deal(player, 1 ether);
    }

    function test_coinflip() public{
        vm.startPrank(player);
        for (uint256 i = 0 ; i<10 ;){
            solution.attack(address(level));
            vm.roll(block.number + 1);
            i++;
        }
    assertEq(10, level.consecutiveWins(),"attack successful ");
    }
}