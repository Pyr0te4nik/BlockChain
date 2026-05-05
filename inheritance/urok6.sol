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

    function withdraw(address payable _to) public virtual onlyOwner {
        payable(_to).transfer(address(this).balance);
    }
}

abstract contract Balances is Ownable {
    function getBalance() public view onlyOwner returns(uint) {

        return address(this).balance;
    }

    function withdraw(address payable _to) public override virtual {
        _to.transfer(getBalance());
    }
}

// Ownable
// Balances
// MyContract

contract MyContract is Ownable, Balances {
    constructor(address _owner) {
        owner = _owner;
    }

    function withdraw(address payable _to) public override(Ownable, Balances) onlyOwner {
        //Balances.withdraw(_to);
        //Ownable.withdraw(_to);
        require(_to != address(0), "zero addr");
        super.withdraw(_to);
    }
}