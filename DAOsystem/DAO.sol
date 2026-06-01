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
    uint public proposalsCounter;

    event ProposalCreated(uint id, address creator, TypeProposal ProposalType);
    event ProposalExecuted(uint id, address creator);
    event ProposalDeleted(uint id, address creator);
    event Voted(uint id);

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
        uint endProposal = votingDuration;

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
            true
        ));

        emit ProposalCreated (id, msg.sender, _proposalType);
    }

    function vote() external {
        
    }

    function deleteProposal() external {

    }

    function executeProposal() external {

    }

    function showMembers() public returns (address[] memory) {
        require(legalMember[msg.sender], unicode"Только участники DAO могут посмотреть список!");
        return members;
    }
}