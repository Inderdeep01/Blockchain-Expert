pragma solidity >=0.4.22 <=0.8.17;

contract RestrictedCount {
    int private counter;
    address private owner;
    int upperLimit = 100;
    int lowerLimit = -100;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender==owner, "Only owner");
        _;
    }

    modifier addLimit(int x){
        require(!(counter+x>upperLimit || counter+x<lowerLimit), "Out of Limit");
        _;
    }

    modifier subLimit(int x){
        require(!(counter-x>upperLimit || counter-x<lowerLimit), "Out of Limit");
        _;
    }

    function getCount() public view returns (int){
        return counter;
    }

    function add(int value) public onlyOwner addLimit(value){
        counter += value;
    }

    function subtract(int value) public onlyOwner subLimit(value) {
        counter -= value;
    }
    
}