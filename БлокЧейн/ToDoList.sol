// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ToDoList {
    struct Task {
        string textTask;
        bool completeTask;
    }

    enum Status { Open, InProgress, Done }
    Status public currentStatus;

    bytes public data;

    uint[] public numbers;
    uint public len;
    string[] public tasks;

    function getNumber() public {
        numbers.push(15);
        numbers.push(156);
        numbers.push(1);
        len = numbers.length;
    }

    function dynamicTasks() public {
        tasks.push("idi");
        tasks.push("na");
        tasks.push("hui");
        len = tasks.length;
    }

    function setData(bytes memory _data) public view returns(bytes memory) {

    }

    // function getNumber(uint number) public view returns(uint) {
    //     numbers += number;
    //     return numbers;
    // }

    function addTask(string memory text) external returns(string memory) {
        tasks = string.concat(tasks, text);
    }
}