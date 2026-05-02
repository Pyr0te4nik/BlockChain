// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ToDoList {
    struct Task {
        string textTask;
        bool completeTask;
    }

    enum Status { Open, InProgress, Done }
    Status public currentStatus;
    // mapping(uint => string) public currentStatusik;

    bytes public data;

    int[] public numbers;
    uint public len;
    Task[] public tasks;

    function setData(bytes memory _data) public {
        data = _data;
    }

    function addNumber(int number) public {
        numbers.push(number);
    }

    function getNumber(uint index) public view returns(int) {
        return numbers[index];
    }

    function addTask(string memory text) public {
        tasks.push(Task(text, false));
    }

    function getTask(uint index) public view returns(string memory, bool) {
        Task memory task = tasks[index];
        return (task.textTask, task.completeTask);
    }

    function markDone(uint index) public {
        tasks[index].completeTask = true;
    }

    function setStatus(Status newStatus) public {
        currentStatus = newStatus;
    }

    function receiveFunds() public payable {

    }
    
    function transferTo(address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }

    function getBalance(address targetAddress) public view returns(uint) {
        return targetAddress.balance;
    }
}
