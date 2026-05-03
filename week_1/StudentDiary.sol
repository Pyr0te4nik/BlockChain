// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StudentDiary {
    address public student;
    string public nameStudent = "Misha";
    int public urok;
    bool public statusStudent;
    mapping (string => uint) public egoLesson;
    mapping (address => uint) public payments;

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

    function umnozhenie(int newNumber) public pure returns (int) {
        return newNumber * 2;
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
