// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BaseContract {
    struct Item {
        uint id;
        string name;
        uint value;
    }
    
    mapping(uint => Item) public items;
    
    function addItem(uint _id, string memory _name, uint _value) external {
        items[_id] = Item(_id, _name, _value);
    }
}