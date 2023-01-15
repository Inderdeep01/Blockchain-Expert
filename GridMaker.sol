pragma solidity >=0.4.22 <=0.8.17;

contract GridMaker {
    function make2DIntGrid(
        uint256 rows,
        uint256 cols,
        int256 value
    ) public pure returns (int256[][] memory) {
        // Write your code here
        int[][] memory array = new int[][](rows);
        for(uint i;i<rows;i++){
            array[i] = new int[](cols);
            for(uint j;j<cols;j++){
                array[i][j] =  value;
            }
        }
        return array;
    }

    function make2DAddressGrid(uint256 rows, uint256 cols)
        public
        view
        returns (address[][] memory)
    {
        // Write your code here
        address[][] memory array = new address[][](rows);
        for(uint i;i<rows;i++){
            array[i] = new address[](cols);
            for(uint j;j<cols;j++){
                array[i][j] = msg.sender;
            }
        }
        return array;
    }
}
