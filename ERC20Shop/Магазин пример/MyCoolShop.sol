// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./MyCoolToken.sol";

contract SimpleShop {
    MyCoolToken public token;
    address public owner;

    // ---------------- Товары ----------------
    enum ProductType {
        MOPED, // 0
        HELMET, // 1
        ACCESSORY // 2
    }

    // Структура для товара
    struct Product {
        string name;
        uint256 price;
        uint256 available;
    }

    // Массив товаров
    Product[] public products;

    // Кто что купил
    mapping(address => mapping(ProductType => uint256)) public purchases;

    // Событие покупки
    event Bought(
        address indexed buyer,
        ProductType indexed product,
        uint256 amount,
        uint256 totalPrice
    );

    // ---------------- Конструктор ----------------
    constructor(address _token) {
        token = MyCoolToken(_token);
        owner = msg.sender;

        // Добавляем товары
        products.push(Product("Moped", 100 * 10 ** 18, 10)); // 100 токенов, 10 штук (10**18 -> возведение в степень decimals, 10 является обязательным, меняется только число 18)
        products.push(Product("Helmet", 20 * 10 ** 18, 50)); // 20 токенов, 50 штук
        products.push(Product("Accessory pack", 5 * 10 ** 18, 100)); // 5 токенов, 100 штук
    }

    // ---------------- Покупка товара ----------------
    function buyProduct(ProductType productType, uint256 amount) public {
        require(uint8(productType) < products.length, "Invalid product type");
        require(amount > 0, "Amount must be greater than 0");

        Product storage product = products[uint8(productType)];

        require(product.available >= amount, "Not enough items available");

        uint256 totalPrice = product.price * amount;

        require(
            token.balanceOf(msg.sender) >= totalPrice,
            "Not enough tokens to buy"
        );

        // Покупатель должен заранее сделать approve
        token.transferFrom(msg.sender, address(this), totalPrice);

        product.available -= amount;
        purchases[msg.sender][productType] += amount;

        emit Bought(msg.sender, productType, amount, totalPrice);
    }

    // ---------------- Статистика по покупкам ----------------
    function getPurchaseCount(
        address buyer,
        ProductType product
    ) public view returns (uint256) {
        return purchases[buyer][product];
    }

    // ---------------- Вывод токенов владельцу ----------------
    function withdrawTokens() public {
        require(msg.sender == owner, "Only owner can withdraw tokens.");

        uint256 balance = token.balanceOf(address(this));
        require(balance > 0, "No tokens to withdraw.");

        token.transfer(owner, balance);
    }

    // ---------------- Вспомогательные функции ----------------
    function getProductCount() public view returns (uint256) {
        return products.length;
    }

    function getProductInfo(
        ProductType product
    )
        public
        view
        returns (string memory name, uint256 price, uint256 available)
    {
        Product storage p = products[uint8(product)];
        return (p.name, p.price, p.available);
    }
}
