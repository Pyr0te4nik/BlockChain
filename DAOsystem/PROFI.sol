// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./ERC20.sol";

contract Professional is ERC20 {
    constructor(address[] memory _members) ERC20("Professional", "PROFI", 12) {
        uint totalSupply = 100000 * 10 ** 12;

        uint amountPerUser = totalSupply / _members.length;

        for (uint i = 0; i < _members.length; i++) {
            _mint(_members[i], amountPerUser);
        }
    }

    function transferFrom(address from, address to, uint amount) public override returns(bool) {
        _transfer(from, to, amount);
        return true;
    }
}
