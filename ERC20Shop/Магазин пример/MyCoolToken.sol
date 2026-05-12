// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./ERC20.sol";

contract MyCoolToken is ERC20 {
    /// Общая максимальная эмиссия в "целых" токенах (без decimals)
    /// Например: 1_000_000_000 == 1 млрд токенов
    uint256 public constant totalCap = 1_000_000_000;

    /// Конструктор: создаём токен и сразу майнтим токены на deployer-а
    ///
    /// Параметр "amount" — это сколько токенов нужно напечатать
    /// в "человеческом виде" (например, 1000, 1000000 и т.п.)
    ///
    /// Внутри:
    /// - создаётся токен с именем "My Cool Token", тикером "MCT", 18 decimals
    /// - минтим "amount * 10 ** decimals()" токенов на адрес `msg.sender`
    ///
    constructor(uint256 amount) ERC20("My Cool Token", "MCT", 18) {
        // Проверяем, что запрошенное количество не превышает максимальную эмиссию
        require(
            amount <= totalCap,
            "MyCoolToken: amount exceeds total cap"
        );

        // Минтим токены именно на адрес того, кто делает деплой (msg.sender)
        // amount — в целых токенах
        // (10 ** decimals()) — умножаем на 10^18, чтобы перевести в виртуальные wei
        _mint(msg.sender, amount * (10 ** 18)); 
        // 18 -> decimals. В ERC20.sol он указан явно, поэтому здесь decimals() не переопределяем. 
        //При другом значении необходимо переопределить функцию decimals и писать 10**decimals(). 10 всегда остается неизмененным.
    }
}