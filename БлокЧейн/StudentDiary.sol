// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StudentDiary {
    address public student;
    string public nameStudent = "Misha";
    string public ocenkaStudent;
    mapping(address => uint) public addressStudent;
    string public Math;
    string public Russian;
    string public English;
    int public number;
    int public urok;
    bool public statusStudent;
    string public lesson;
    mapping(string => int) public egoLesson;

    constructor() {
        student = msg.sender;
        lesson = Math;
    }

    function i(
        uint amount,
        string memory newOcenka
    ) external returns (string memory) {
        require(amount <= 5, "invalid numb");
        Math = string.concat(Math, newOcenka, " ");
        ocenkaStudent = string.concat(ocenkaStudent, newOcenka, " ");
        return ocenkaStudent;
    }
    
    function setOcenkaMath(
        string memory newOcenka
    ) external returns (string memory) {
        Math = string.concat(Math, newOcenka, " ");
        ocenkaStudent = string.concat(ocenkaStudent, newOcenka, " ");
        return ocenkaStudent;
    }

    function setOcenkaRus(
        string memory newOcenka
    ) external returns (string memory) {
        Russian = string.concat(Russian, newOcenka, " ");
        ocenkaStudent = string.concat(ocenkaStudent, newOcenka, " ");
        return ocenkaStudent;
    }

    function setOcenkaEng(
        string memory newOcenka
    ) external returns (string memory) {
        English = string.concat(English, newOcenka, " ");
        ocenkaStudent = string.concat(ocenkaStudent, newOcenka, " ");
        return ocenkaStudent;
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
}
