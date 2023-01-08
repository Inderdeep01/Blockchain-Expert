pragma solidity ^0.8.0;

contract StringGenerator {
    bytes private s;
    mapping(address=>bool) map;
    function addCharacter(string memory character) public {
        // Write your code here
        bytes memory char = bytes(character);
        require(char.length==1,"Invalid character");
        require(map[tx.origin]!=true,"You have already added your character");
        require(s.length<5,"You cannot add more characters to this string");
        map[tx.origin] = true;
        s.push(char[0]);
    }

    function getString() public view returns (string memory) {
        // Write your code here
        string memory res = string(s);
        return res;
    }
}
