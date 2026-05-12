// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./BaseTaskManager.sol";

contract TaskManager is BaseTaskManager {
    mapping(uint => uint) public points;
    enum Status { Open, InProgress, Done }
    Status public globalStatus;

    uint public totalPoints;

    function setStatus(Status newStatus) public {
        globalStatus = newStatus;
    }

    function addTaskWithPoints(string memory text, uint _points) public {
        require(_points <= 100, unicode"Оценка не может превысить 100 баллов!");
        points[_points];
        super.addTask(text);
        totalPoints += _points;
    }

    function GetTask(uint index) public view /*override*/ returns(string memory, bool, uint) {
        Task memory task = tasks[index];
        return (task.text, task.done, totalPoints);
    }

    function markDone(uint index) public override {
        super.markDone(index);
        totalPoints += 10;
    }
}