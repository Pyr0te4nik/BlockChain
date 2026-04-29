// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract MyShop {
    address public parebuh; // наименование адреса
    mapping (address => uint) public payments; 

    constructor() {
        parebuh = msg.sender;
    }

    function payForItem() external payable returns(uint) {
        payments[msg.sender] += msg.value;
        return msg.value;
    }

    function withdrawAll() public {
        address payable _to = payable(parebuh);
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
        payments[msg.sender] = 0;
    }
}
