pragma solidity ^0.6.0;

contract MappingStructExample {
    
    mapping(address => uint) public balanceReceived; 
    
    constructor() public payable {
        
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
        
    }
    
    function withdrawAllMoney(address payable _to) public {
        
        uint balanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(address(this).balance); 
    }
}