// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./PROFI.sol";

contract DAO {
    enum TypeProposal { InvestStartUp, AddInvest, AddMember, ExclusionMember, TokenManagement }

    struct Proposal {
        uint idProposal;
        TypeProposal proposalType;
        address creator;
        address targetAddress;
        uint amount;
        string description;
        uint timeStartProposal;
        uint timeEndProposal;
        uint amountVoteYES;
        uint amountVoteNO;
        bool executed;
        bool deleted;
        bool accepted;
    }

    Professional public PROFI;
    Proposal[] public proposals;
    mapping (address => bool) public legalMember;
    mapping (uint => Proposal) public proposal;
    mapping (uint => mapping (address => bool)) public hasVoted;
    address[] public members;
    uint public proposalsCounter = 0;

    event ProposalCreated(uint id, address creator, TypeProposal ProposalType);
    event ProposalExecuted(uint id, address creator);
    event ProposalDeleted(uint id, address creator);
    event Voted(uint id, address voter, bool vote);

    constructor(address token, address[] memory _members) {
        require (token != address(0), unicode"Адрес токена не указан!");
        PROFI = Professional(token);

        for (uint256 i = 0; i < _members.length; i++) {
            if (!legalMember[_members[i]]) {
                legalMember[_members[i]] = true;
                members.push(_members[i]);
            }
        }
    }
    
    function createProposal(TypeProposal _proposalType, address _targetAddress, uint _amount, uint votingDuration, string memory _description) external {
        require (legalMember[msg.sender], unicode"Вы не участник DAO!");

        uint startProposal = block.timestamp;
        uint endProposal = startProposal + votingDuration;

        uint id = proposalsCounter++;

        Proposal storage prop = proposal[id];

        proposals.push(Proposal(
            id,
            _proposalType,
            msg.sender,
            _targetAddress, 
            _amount, 
            _description, 
            startProposal, 
            endProposal, 
            0,
            0,
            false,
            false,
            false
        ));

        emit ProposalCreated (id, msg.sender, _proposalType);
    }

    function vote(uint proposalId, bool _vote) external {
        require (proposal[proposalId].creator != address(0), unicode"Голосования не существует!");

        Proposal storage p = proposal[proposalId];

        require (p.executed = false, unicode"Голосование завершено!");
        require (p.deleted = false, unicode"Голосование удалено!");
        require (!hasVoted[proposalId][msg.sender], unicode"Ваш голос уже учтен!");
        require (legalMember[msg.sender], unicode"Вы не участник DAO!");
        require (block.timestamp < p.timeEndProposal, unicode"Голосование подошло к концу!");

        uint userBalance = PROFI.balanceOf(msg.sender);
        require (userBalance > 0, unicode"У вас недостаточно токенов!");

        if (_vote) {
            p.amountVoteYES += userBalance;
        } else {
            p.amountVoteNO += userBalance;
        }

        hasVoted[proposalId][msg.sender] = true;
        
        emit Voted (proposalId, msg.sender, _vote);
    }

    function deleteProposal(uint proposalId) external {
        require (proposal[proposalId].creator != address(0), unicode"Голосования не существует!");
        require (proposal[proposalId].creator == msg.sender, unicode"Вы не создатель голосования!");

        Proposal storage p = proposal[proposalId];

        require (p.executed = false, unicode"Голосование завершено!");
        require (p.deleted = false, unicode"Голосование удалено!");
        require (legalMember[msg.sender], unicode"Вы не участник DAO!");
        require (block.timestamp < p.timeEndProposal, unicode"Голосование подошло к концу!");

        p.deleted = true;

        emit ProposalDeleted (proposalId, msg.sender);
    }

    function executeProposal(uint proposalId) external {
        require (proposal[proposalId].creator != address(0), unicode"Голосования не существует!");
        require (proposal[proposalId].creator == msg.sender, unicode"Вы не создатель голосования!");

        Proposal storage p = proposal[proposalId];

        require (p.executed = false, unicode"Голосование завершено!");
        require (p.deleted = false, unicode"Голосование удалено!");
        require (legalMember[msg.sender], unicode"Вы не участник DAO!");
        require (block.timestamp < p.timeEndProposal, unicode"Голосование подошло к концу!");

        if (p.amountVoteYES > p.amountVoteNO) {
            p.accepted = true;
        } else {
            p.accepted = false;
        }

        p.executed = true;

        emit ProposalExecuted (proposalId, msg.sender);
    }

    function showMembers() public returns (address[] memory) {
        require(legalMember[msg.sender], unicode"Только участники DAO могут посмотреть список!");
        return members;
    }
}