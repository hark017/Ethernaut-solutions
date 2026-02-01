// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

// Purpose of this level is to claim ownership

// import "../helpers/Ownable-05.sol"; // due to compilation error

contract AlienCodex {
    //is Ownable {
    address private _owner; // slot 0 as owner address
    bool public contact;
    bytes32[] public codex;

    modifier contacted() {
        assert(contact);
        _;
    }

    function makeContact() public {
        contact = true;
    }

    function record(bytes32 _content) public contacted {
        codex.push(_content);
    }

    function retract() public contacted {
        codex.length--;
    }

    function revise(uint256 i, bytes32 _content) public contacted {
        codex[i] = _content;
    }
}
