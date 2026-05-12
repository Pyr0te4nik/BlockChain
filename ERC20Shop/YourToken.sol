// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./ERC20.sol";

contract Token is ERC20 {
    constructor(address shop) ERC20("Token", "T", 20000000000000000000, shop) {
    }
}
