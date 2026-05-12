// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./1.sol";

contract ExtendedContract is BaseContract {
    mapping(uint => uint) public extraValue; // дополнительное поле для Item
    mapping(uint => address) public owner;   // ещё одно доп. поле
    
    function setExtra(uint _itemId, uint _extra) external {
        extraValue[_itemId] = _extra;
    }
}