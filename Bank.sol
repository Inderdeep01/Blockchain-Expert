pragma solidity >=0.4.22 <=0.8.17;

abstract contract SignUpBonus {
    mapping(address => uint) ledger;
    mapping (address=>bool) firstDepositMade;
    function getBonusAmount() internal virtual view returns (uint);
    function getBonusRequirements() internal virtual pure returns (uint);
    
    function deposit() public payable {
        if(!firstDepositMade[msg.sender] ){
            uint bonusThreshold = getBonusRequirements();
            if(msg.value>= bonusThreshold){
                uint bonus = getBonusAmount();
                ledger[msg.sender] += bonus;
            }
            firstDepositMade[msg.sender] = true;
        }
        ledger[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(amount <= ledger[msg.sender], "Insufficient balance");
        ledger[msg.sender] -= amount;
        (bool sent,) = payable(msg.sender).call{value: amount}("");
        require(sent, "Error transferring funds");
    }

    function getBalance() public view returns (uint){
        return ledger[msg.sender];
    }
}

contract Bank is SignUpBonus {
    function getBonusAmount() internal override view returns (uint){
        return 150 wei;
    }

    function getBonusRequirements() internal override pure returns (uint){
        return 1000 wei;
    }
}
