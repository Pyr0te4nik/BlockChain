// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./BaseTaskManager.sol";

contract TaskManager is BaseTaskManager {
    enum Status { Open, InProgress, Done }
    Status public globalStatus;

    uint public totalPoints;

    function setStatus(Status newStatus) public {
        globalStatus = newStatus;
    }

    function addTaskWithPoints(string memory text, uint points) public {
        require(points >= 100, unicode"Оценка не может превысить 100 баллов!");
        super.addTask(text);
        totalPoints += points;
    }

    function markDone(uint index) public override {
        super.markDone(index);
    }

    // function getTaskk(uint index) public view override returns(string memory, bool, uint) {
    //     Task memory task = taski[index];
    //     return(Task(task.text, task.done, task.points));
    // }
}