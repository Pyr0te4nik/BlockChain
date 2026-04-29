// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Ether {
    address public kosh;
    mapping (address => uint) public addressEgo;

    constructor() {
        kosh = msg.sender;
    }

    function pay() public payable {
        addressEgo[msg.sender] += msg.value;
    }
}