pragma solidity >=0.4.22 <=0.8.17;

contract Competitors {
    // Write your code here
    address private addr1;
    address private addr2;
    address private owner;
    uint private balance;
    mapping(address=>uint) private txns;
    uint limit = 3 ether;
    bool private isSent = false;

    constructor(){
        owner = msg.sender;
    }

    function deposit() public payable{
        require(msg.value==1 ether,"Inappropriate amount!");
        require(balance<=limit,"Already Full!");
        if(addr1==address(0)){
            addr1 = msg.sender;
        }
        else if(msg.sender!=addr1 && addr2==address(0)){
            addr2 = msg.sender;
        }
        require(msg.sender==addr1 || msg.sender==addr2,"Invalid Address");
        balance += msg.value;
        txns[msg.sender]+=msg.value;
    }

    function withdraw() external {
        require(balance==limit,"Insufficient balance yet");
        address winner;
        if(txns[addr1]>txns[addr2]){
            winner = addr1;
        }
        else{
            winner = addr2;
        }
        require(msg.sender==winner,"You are not the winner");
        uint amt = balance;
        balance = 0;
        (bool sent,) = payable(winner).call{value:amt}("");
        require(sent,"Payment failed");
        isSent = true;
    }

    function destroy() external{
        require(isSent,"Invalid Call");
        require(msg.sender==owner,"Invalid Call");
        selfdestruct(payable(owner));
    }

}
