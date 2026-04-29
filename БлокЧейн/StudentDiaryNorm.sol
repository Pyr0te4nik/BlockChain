// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StudentDiary {
    address public student;
    string public nameStudent = "Misha";
    int public number;
    int public urok;
    bool public statusStudent;
    mapping(string => uint) public egoLesson;
    mapping(address => uint) public payments;

    constructor() {
        student = msg.sender;
    }

    function replace(string memory bulba, uint ocenka) public {
        require(ocenka <= 5, "oshibka");
        egoLesson[bulba] = ocenka;
    }

    function swapStatusActive() public {
        statusStudent = true;
    }

    function swapStatusInactive() public {
        statusStudent = false;
    }

    function completeUrok() public {
        urok++;
    }

    function umnozhenie(int newNumber) external returns (int) {
        number = newNumber * 2;
        return number;
    }

    function payForItem() external payable returns(uint) {
        payments[msg.sender] += msg.value;
        return msg.value;
    }

    function withdrawAll() public {
        address payable _to = payable(student);
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
        payments[msg.sender] = 0;
    }
}
