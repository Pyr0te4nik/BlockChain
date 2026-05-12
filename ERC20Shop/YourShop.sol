// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./YourToken.sol";

contract TShop {
    enum ProductType { VEGETABLE, FRUIT, MEAT }
    struct Product {
        string name;
        uint price;
        uint available;
    }

    Product[] public products;

    mapping(address => mapping(ProductType => uint)) public purchases;

    ERC20 public token;
    address payable public owner;
    event Bought(address indexed _buyer, ProductType indexed product, uint _amount, uint totalPrice);

    constructor() {
        token = new Token(address(this));
        owner = payable(msg.sender);

        products.push(Product("Cucumber", 10000000000000000000, 50));
        products.push(Product("Apple", 10000000000000000000, 50));
        products.push(Product("Chicken", 10000000000000000000, 30));
    }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "not an owner!");
    //     _;
    // }

    // function sell(uint _amountToSell) external {
    //     require(_amountToSell > 0 && token.balanceOf(msg.sender) >= _amountToSell, "incorrect amount!");

    //     uint allowance = token.allowance(msg.sender, address(this));
    //     require(allowance >= _amountToSell, "check alloance!");

    //     token.transferFrom(msg.sender, address(this), _amountToSell);

    //     payable(msg.sender).transfer(_amountToSell);

    //     emit Sold(_amountToSell, msg.sender);
    // }

    // receive() external payable {
    //     uint tokensToBuy = msg.value;
    //     require(tokensToBuy > 0, "not enough funds!");

    //     require(tokenBalance() >= tokensToBuy, "not enough tokens!");

    //     token.transfer(msg.sender, tokensToBuy);
    //     emit Bought(tokensToBuy, msg.sender);
    // }

    // function tokenBalance() public view returns(uint) {
    //     return token.balanceOf(address(this));
    // }

    function buyProduct(ProductType productType, uint256 amount) public {
        require(uint8(productType) < products.length, "Invalid product type");
        require(amount > 0, "Amount must be greater than 0");

        Product storage product = products[uint8(productType)];

        require(product.available >= amount, "Not enough items available");

        uint256 totalPrice = product.price * amount;

        require(token.balanceOf(msg.sender) >= totalPrice, "Not enough tokens to buy");

        // Покупатель должен заранее сделать approve
        token.transferFrom(msg.sender, address(this), totalPrice);

        product.available -= amount;
        purchases[msg.sender][productType] += amount;

        emit Bought(msg.sender, productType, amount, totalPrice);
    }

    // ---------------- Статистика по покупкам ----------------
    function getPurchaseCount(address buyer, ProductType product) public view returns (uint256) { 
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

    function getProductInfo(ProductType product) public view returns (string memory name, uint256 price, uint256 available) {
        Product storage _product = products[uint8(product)];
        return (_product.name, _product.price, _product.available);
    }
}