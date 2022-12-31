pragma solidity >=0.4.22 <=0.8.17;

contract Richest {
    // Write your code here
    mapping (address=>uint) private assets;
    address private richAddr = address(0);
    //address private prevAddr = address(0);
    
    // function to receive ether
    function becomeRichest() external payable returns(bool){
        if(msg.value>assets[richAddr]){
            //assets[prevAddr] = 0;
            //prevAddr = richAddr;
            richAddr = msg.sender;
            assets[richAddr] = msg.value;
            return true;
        }
        return false;
    }

    function withdraw() external{
        if(tx.origin!=richAddr){
            uint value = assets[msg.sender];
            assets[msg.sender] = 0;
            //address payable receiver = msg.sender
            payable(msg.sender).call{value:value}("");
        }
    }
    function getRichest() external view returns(address){
        return richAddr;
    }
}
