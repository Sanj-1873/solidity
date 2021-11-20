pragma solidity ^0.5.13;
contract ExceptionExample {
    
    mapping(address => uint) public balanceReceived;
    
    function revceiveMoney() public payable {
        assert(balanceReceived[msg.sender] + uint(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
        
    }
}