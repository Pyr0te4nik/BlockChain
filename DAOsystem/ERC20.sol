// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
 
    mapping(address => uint256) public balanceOf;
 
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    address public owner;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        totalSupply = 0;
        owner = msg.sender;
    }

    function _mint(address to, uint256 amount) internal {
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function _burn(address from, uint256 amount) internal {
        uint256 fromBalance = balanceOf[from];
        require(fromBalance >= amount, "ERC20: burn amount exceeds balance");

        unchecked {
            balanceOf[from] = fromBalance - amount;
        }
        totalSupply -= amount;
        emit Transfer(from, address(0), amount);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual returns (bool) {
        uint256 currentAllowance = allowance[from][msg.sender];

        require(currentAllowance >= amount, "ERC20: amount exceeds allowance");

        allowance[from][msg.sender] = currentAllowance - amount;
        _transfer(from, to, amount);
        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(from != address(0), "ERC20: from the zero address");
        require(to != address(0), "ERC20: to the zero address");

        uint256 fromBalance = balanceOf[from];
        require(fromBalance >= amount, "ERC20: amount exceeds balance");

        unchecked {
            balanceOf[from] = fromBalance - amount;
        }
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);
    }
}