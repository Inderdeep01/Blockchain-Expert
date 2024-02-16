pragma solidity >=0.4.22 <=0.8.17;

library Array {
    function indexOf(int[] memory numbers, int target) public pure returns (int){
        uint n = numbers.length;
        for(uint i=0; i<n; i++){
            if(numbers[i]==target){
                return int(i);
            }
        }
        // If reached here, then target does not exists
        return -1;
    }

    function count(int[] memory numbers, int target) public pure returns (uint){
        uint x;
        uint n = numbers.length;
        for(uint i;i<n; i++){
            if(numbers[i]==target){
                x++;
            }
        }
        return x;
    }

    function sum(int[] memory numbers) public pure returns (int){
        int x = 0;
        uint n = numbers.length;
        for(uint i;i<n;i++){
            x += numbers[i];
        }
        return x;
    }
}