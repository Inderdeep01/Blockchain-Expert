pragma solidity >=0.4.22 <=0.8.17;

contract EventEmitter {
    // Write your code here
    uint private n = 1;
    event Called(uint count,address indexed sender);

    function count() public{
        emit Called(n,msg.sender);
        n++;
    }
}
