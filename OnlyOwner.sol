pragma solidity >=0.4.22 <=0.8.17;

contract OnlyOwner {
    // Write your code here
    address private owner;
    uint8 private stateNumber;
    constructor(){
        owner = msg.sender;
    }

    function add(uint8 number) external {
        require(msg.sender==owner,"Unauthorised");
        stateNumber += number;
    }

    function subtract(uint8 number) external {
        require(msg.sender==owner,"Unauthorised");
        stateNumber -= number;
    }

    function get() external view returns(uint8){
        require(msg.sender==owner,"Unautorised");
        return stateNumber;
    }
}
