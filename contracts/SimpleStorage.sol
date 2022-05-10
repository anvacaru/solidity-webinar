// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract SimpleStorage {

    uint storedData; // 0 - 2^256-1
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }
    function setValue(uint x) public {
        storedData = x;
    }

    function getValue() public view returns (uint) {
        return storedData;
    }
}