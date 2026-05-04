// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BaseTaskManager {
    struct Task {
        string text;
        bool done;
    }

    Task[] public taski;
 
    uint public taskCount;
    mapping (uint => Task) public tasks;

    function addTask(string memory text) public virtual {
        taskCount++;
        taski.push(Task(text, false));
    }

    function getTask(uint index) public view virtual returns (string memory, bool) {
        Task memory task = taski[index];
        return (task.text, task.done);
    }

    function markDone(uint index) public virtual {
        taski[index].done = true;
    }


}
