pragma solidity ^0.5.13;

contract FunctionsExample {
    // balanceReceived and owner are storage variables
    mapping(address => uint) public balanceReceived;
    
    address payable owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    //view function
    // can call pure functions but it cannot call writing functions
    function getOwner() public view returns(address) {
        return owner;
    }
    
    
    //pure function --> does not interact with storage variables 
    // pure functions can call other pure functions but it cannot call view functions or write functions 

    // writing functions can call both pure and view functions
    
    function convertWeiToEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether; 
    }
    function destroySmartContract() public  {
        require(msg.sender == owner,"You are not the owner");
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;

    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    function () external payable {
        receiveMoney();
    }
}