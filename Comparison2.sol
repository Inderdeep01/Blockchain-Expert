pragma solidity >=0.4.22 <=0.8.17;

contract Comparison2 {
    function compare(int256 a, int256 b) public pure returns (int256) {
        // Write your code here
        int x = 0;
        int y = 1;
        int z = -1;
        return a!=b ? (a>b ? y : z) : x;
    }
}
