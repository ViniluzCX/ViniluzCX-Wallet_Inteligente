// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract WalleImplementation {

    address public owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public guardians;
    mapping(address => address []) public guardiansVotes;

    constructor() {
        owner = msg.sender;
    }

    event FundsSent(address indexed to, uint amount);
    event AllowanceChanged(address indexed spender, uint amount);
    event GuardianVote(address indexed guardian, address indexed newOwner);
    event NewOwner(address indexed newOwner);


    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function proposeNewOwner(address _newOwner) external {
        require (guardians[msg.sender], "Not a guardian");

        address [] storage votes = guardiansVotes[_newOwner];
        for (uint i = 0; i < votes.length; i++) {
            require(votes[i] != msg.sender, "Already voted");
        }

        votes.push(msg.sender);
        guardiansVotes[_newOwner] = votes;

        if (votes.length >= 3) {
            owner = _newOwner;
            delete guardiansVotes[_newOwner];
            emit NewOwner(_newOwner);
        }
        emit GuardianVote(msg.sender, _newOwner);
        

    }

    function setGuardian(address _guardian, bool _isGuardian) external onlyOwner {
        guardians[_guardian] = _isGuardian;
    }

    function sendFunds(address payable _to, uint amount) external onlyOwner {
        require(_to != address(0), "Invalid address");
        (bool verify, ) = _to.call{value: amount}("");
        require(verify, "Failed to send Ether");
        emit FundsSent(_to, amount);

    }

    function setAllowance(address _spender, uint _amount) external onlyOwner() {
        allowance[_spender] = _amount;
        emit AllowanceChanged(_spender, _amount);

    }
    
    function spendFund(address payable _to, uint _amount) external {
        require(allowance[msg.sender] >= _amount, "Allowance exceeded");
        require(_to != address(0), "Invalid address");
        allowance[msg.sender] -= _amount;
        (bool verify, ) = _to.call{value: _amount}("");
        require(verify, "Failed to send Ether");
        emit AllowanceChanged(msg.sender, allowance[msg.sender]);
    }


    receive() external payable {
        // This contract can receive Ether
    }   

    fallback() external payable {
        // This contract can handle calls to non-existent functions
    }
}