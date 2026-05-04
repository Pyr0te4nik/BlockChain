// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "not an owner!");
        _;
    }
}

contract Balances is Ownable {
    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    function withDraw(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }
}

// Ownable
// Balances
// Demo

contract Demo is Ownable, Balances {
    
}