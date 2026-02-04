// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";

import "./Stake.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";

contract test_solution is Test {
    Stake level;
    address player = makeAddr("player");
    ERC20 _dweth;

    function setUp() public {
        _dweth = new ERC20("DummyWETH", "DWETH");
        level = new Stake(address(_dweth));
    }
}
