// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BankStore {
    mapping(address => uint) public balances;

    bool guard;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    modifier noReentry() {
        require(guard == false);
        guard = false;
        _;
        guard = true;
    }

    function withdraw() public noReentry {
        uint bal = balances[msg.sender];
        require(bal > 0);

        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}