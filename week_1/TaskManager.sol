// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract TaskManager {
    struct Task {
        string text;
        bool done;
        uint points;
    }

    Task[] public tasks;

    bytes public configData;

    string public ownerName = "Grisha";
    address public owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bool public isActive = true;
    mapping(string => uint) public tagsCount;

    uint[5] public levels;
    uint[] public points;

    enum Status { Open, InProgress, Done }
    Status public globalStatus;

    function addTask(string memory text, uint point) public {
        require(point <= 100, unicode"Оценка не может превысить 100 баллов");
        tasks.push(Task(text, false, point));
        // points.push(point);
    }

    function getTask(uint index) public view returns (string memory, bool, uint) {
        Task memory task = tasks[index];
        return (task.text, task.done, task.points);
    }

    function markDone(uint index) public {
        tasks[index].done = true;
    }

    function setStatus(Status newStatus) public {
        globalStatus = newStatus;
    }

    function addPoints(uint pointValue) public {
        require(pointValue <= 100, unicode"Оценка не может превысить 100 баллов");
        points.push(pointValue);
    }

    function getPointCount() public view returns(uint) {
        return points.length;
    }

    function setLevel(uint index, uint value) public {
        levels[index] = (value);
    }

    function setConfig(bytes memory data) public {
        configData = data;
    }

    function addTag(string memory tag) public {
        tagsCount[tag]++;
    }

    function deposit() public payable { // функция для перевода средств на счет контракта

    }
    
    function transferTo(address targetAddr, uint amount) public { // функция для перевода средств на любой контракт
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }

    function getBalance() public view returns(uint) { // функция для просмотра баланса любого контракта по адресу
        return address(this).balance;
    }
}