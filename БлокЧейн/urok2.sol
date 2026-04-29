// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract number2 {
    // public
    // external
    // internal
    // private

    // view
    // pure
    string message = "hello!"; // state
    uint public balance;
    // call

    fallback() external payable {
        
    }

    receive() external payable {
        //balance += msg.value;
    }

    function pay() external payable {
        balance += msg.value;
    }

    // transaction
    function setMessage(string memory newMessage) external returns(string memory) {
        message = newMessage;
        return message;
    }

    function getBalance() public view returns(uint balance) {
        balance = address(this).balance;
        // return balance;
    }

    function getMassage() external view returns(string memory) {
        return message;
    }

    function rate(uint amount) public pure returns(uint) {
        return amount * 3;
    }
}
