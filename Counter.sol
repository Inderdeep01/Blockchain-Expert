pragma solidity >=0.4.22 <=0.8.17;

contract Counter {
    uint256 public count;

    function increment() external {
        // Write your code here
        count++;
    }

    function decrement() external {
        // Write your code here
        count--;
    }

    function reset() external {
        // Write your code here
        count = 0;
    }

    function addBy(uint256 value) external {
        // Write your code here
        count+=value;
    }

    function subtractBy(uint256 value) external {
        // Write your code here
        count-=value;
    }

    function multiplyBy(uint256 value) external {
        // Write your code here
        count*=value;
    }

    function getMinutesElapsed() external view returns (uint256) {
        // Write your code here
        return count/60;
    }
}
