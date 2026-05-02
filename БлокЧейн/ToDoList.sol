// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ToDoList { // контракт :D
    struct Task {
        string textTask;
        bool completeTask;
    } // структура массива Task[]

    enum Status { Open, InProgress, Done }
    Status public currentStatus;
    // mapping(uint => string) public currentStatusik;

    bytes public data;

    int[] public numbers; // массива чисел
    uint public len;
    Task[] public tasks; // массив задач

    function setData(bytes memory _data) public { // функция для хранения байтовых данных в переменной data
        data = _data;
    }

    function addNumber(int number) public { // функция для добавления чисел в массив
        numbers.push(number);
    }

    function getNumber(uint index) public view returns(int) { // функция для вывода чисел из массива по индексу
        return numbers[index];
    }

    function addTask(string memory text) public { // функция для добавления новой задачи
        tasks.push(Task(text, false));
    }

    function getTask(uint index) public view returns(string memory, bool) { // функция для вывода задачи по индексу
        Task memory task = tasks[index];
        return (task.textTask, task.completeTask);
    }

    function markDone(uint index) public { // функция для пометки задачи как выполненная
        tasks[index].completeTask = true;
    }

    function setStatus(Status newStatus) public { // функция для изменения статуса контракта
        currentStatus = newStatus;
    }

    function receiveFunds() public payable { // функция для перевода средств на счет контракта

    }
    
    function transferTo(address targetAddr, uint amount) public { // функция для перевода средств на любой контракт
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }

    function getBalance(address targetAddress) public view returns(uint) { // функция для просмотра баланса любого контракта по адресу
        return targetAddress.balance;
    }
}
