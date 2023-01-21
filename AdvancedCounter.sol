pragma solidity >=0.4.22 <=0.8.17;

contract AdvancedCounter {
    mapping(address=>uint) numberOfCounters;
    mapping(address=>mapping(string=>bool)) ids;
    mapping(address=>mapping(string=>int)) counter;
    function createCounter(string memory id, int256 value) public {
        // Write your code here
        require(!ids[msg.sender][id],"Counter already exist");
        require(numberOfCounters[msg.sender]<3,"Counter Limit Reached");
        ids[msg.sender][id] = true;
        numberOfCounters[msg.sender]+=1;
        counter[msg.sender][id] = value;
    }

    function deleteCounter(string memory id) public {
        // Write your code here
        require(ids[msg.sender][id],"ID doesnot exist");
        numberOfCounters[msg.sender]-=1;
        ids[msg.sender][id] = false;
        counter[msg.sender][id] = 0;
    }

    function incrementCounter(string memory id) public {
        // Write your code here
        require(ids[msg.sender][id],"Invalid ID");
        counter[msg.sender][id]+=1;
    }

    function decrementCounter(string memory id) public {
        // Write your code here
        require(ids[msg.sender][id],"Invalid ID");
        counter[msg.sender][id]-=1;
    }

    function getCount(string memory id) public view returns (int256) {
        // Write your code here
        require(ids[msg.sender][id],"Invalid ID");
        return counter[msg.sender][id];
    }
}
