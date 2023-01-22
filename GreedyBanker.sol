pragma solidity >=0.4.22 <=0.8.17;

contract GreedyBanker {
    address private owner;
    uint private profit;
    mapping(address=>uint) private ledger;
    mapping(address=>bool) private accounts;
    constructor(){
        owner = msg.sender;
    }

    receive() external payable {
        // Write your code here
        if(accounts[msg.sender]){
            require(msg.value>=1000 wei,"Inappropriate amount");
            ledger[msg.sender]+=(msg.value-1000 wei);
            profit+=1000 wei;
        }
        else{
            accounts[msg.sender] = true;
            ledger[msg.sender] = msg.value;
        }
    }

    fallback() external payable {
        // Write your code here
        profit+=msg.value;
    }

    function withdraw(uint256 amount) external {
        // Write your code here
        require(ledger[msg.sender]>=amount,"Inappropriate funds");
        ledger[msg.sender]-=amount;
        (bool sent,) = payable(msg.sender).call{value:amount}("");
        require(sent,"Transaction failed");
    }

    function collectFees() external {
        // Write your code here
        require(msg.sender==owner,"Unauthorized!");
        uint amount = profit;
        profit = 0;
        (bool sent,) = payable(owner).call{value:amount}("");
        require(sent,"Transaction failed");
    }

    function getBalance() public view returns (uint256) {
        // Write your code here
        return ledger[msg.sender];
    }
}
