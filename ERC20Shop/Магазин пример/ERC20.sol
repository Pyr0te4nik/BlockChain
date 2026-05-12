// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ERC20 {
    string public name;        // имя токена, например "MyCoolToken"
    string public symbol;      // тикер, например "MCT"
    uint8 public decimals;     // количество знаков после запятой (18 — стандарт)
    uint256 public totalSupply; // сколько всего токенов в обращении

    // Баланс каждого адреса
    mapping(address => uint256) public balanceOf;

    // Одобрения: кто сколько разрешил тратить
    // allowance[владелец][кто тратит] = количество токенов
    mapping(address => mapping(address => uint256)) public allowance;

    // События, чтобы логировать действия в блокчейне
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Модификатор: только владелец может вызывать функцию
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Владелец контракта (тот, кто делает деплой)
    address public owner;

    /// Конструктор: создаём токен с параметрами, но пока без эмиссии
    /// decimals можно задать сразу (например 18)
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        totalSupply = 0;      // сначала не печатаем ни одного токена
        owner = msg.sender;   // владельцем становится тот, кто деплоит контракт
    }

    /// Внутренняя функция: печать токенов (mint)
    /// Всегда должна увеличивать totalSupply и баланс получателя
    /// вызывается только изнутри контракта (internal)
    function _mint(address to, uint256 amount) internal {
        totalSupply += amount;              // увеличиваем общую эмиссию
        balanceOf[to] += amount;            // добавляем токены адресу
        emit Transfer(address(0), to, amount); // логируем: из "ничего" на адрес to
    }

    /// Внутренняя функция: сжигание токенов (burn)
    /// Уменьшает баланс владельца и totalSupply
    function _burn(address from, uint256 amount) internal {
        uint256 fromBalance = balanceOf[from];
        require(fromBalance >= amount, "ERC20: burn amount exceeds balance");

        unchecked {
            balanceOf[from] = fromBalance - amount;
        }
        totalSupply -= amount;
        emit Transfer(from, address(0), amount); // логируем: от адреса в "ничего"
    }

    /// Перевести токены другому адресу
    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    /// Разрешить другому адресу тратить токены
    /// spender — кто может тратить, amount — сколько
    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    /// Перевести от имени другого адреса (через approve)
    /// from — владелец, to — получатель, amount — сумма
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        uint256 currentAllowance = allowance[from][msg.sender];

        require(currentAllowance >= amount, "ERC20: amount exceeds allowance");

        allowance[from][msg.sender] = currentAllowance - amount;
        _transfer(from, to, amount);
        return true;
    }

    /// Внутренняя функция перевода токенов
    /// Проверяет адреса, баланс и обновляет состояния
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