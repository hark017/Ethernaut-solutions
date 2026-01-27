// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solution {
    function destroy(address _target) public payable {
        selfdestruct(payable(_target));
    }
}
