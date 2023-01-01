pragma solidity >=0.4.22 <=0.8.17;

contract Voting {
    // Write your code here
    mapping(uint8=>uint) private votes;
    uint maxVotes;
    uint8 maxVotesCandidate = 1;
    mapping(address=>bool) private voted;
    
    function getVotes(uint8 number) external view returns (uint){
        require(number>0 && number<=5,"Invalid number");
        return votes[number];
    }
    function vote(uint8 number) external{
        if(voted[msg.sender]){
            revert();
        }
        require(number>0 && number<=5,"Invalid number");
        voted[msg.sender] = true;
        votes[number] +=1;
        if(votes[number]>=maxVotes){
            maxVotes = votes[number];
            maxVotesCandidate = number;
        }
    }

    function getCurrentWinner() external view returns(uint8){
        return maxVotesCandidate;
    }
}
