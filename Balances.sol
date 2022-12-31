pragma solidity >=0.4.22 <=0.8.17;

contract Balances {
    // Write your code here
    mapping(address=>uint) private ledger;

    function getAmountSent(address addr) external view returns (uint){
        return ledger[addr];
    }

    receive() external payable{
        ledger[msg.sender]+=msg.value;
    }
    fallback() external payable{
        ledger[msg.sender]+=msg.value;
    }
}
