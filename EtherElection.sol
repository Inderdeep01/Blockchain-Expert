pragma solidity >=0.4.22 <=0.8.17;

contract EtherElection {
    address private owner;
    address private winner;

    mapping(address=>bool) private candidates;
    mapping(address=>uint) private votes;
    mapping(address=>bool) private voters;
    uint count;

    bool enrollmentOpen = true;
    bool votingDone;
    bool winnerAnnounced;
    bool paymentDone;

    constructor(){
        owner = msg.sender;
    }

    function enroll() public payable {
        // Write your code here
        require(enrollmentOpen,"Enrollment completed. Better Luck next time!");
        require(msg.value==1 ether,"Require 1 ETH as enrollment fees.");
        require(!candidates[tx.origin],"You are already enrolled");
        //require(count<3,"Enrollment completed");
        candidates[msg.sender] = true;
        count+=1;
        if(count==3){
            enrollmentOpen = false;
        }
    }

    function vote(address candidate) public payable {
        // Write your code here
        require(enrollmentOpen==false,"Enrollment not done yet");
        require(!votingDone,"Voting completed");
        require(msg.value==10000 wei,"Insufficient funds to vote");
        require(!voters[tx.origin],"You have already voted");
        require(candidates[candidate],"Wrong candidate address");
        voters[tx.origin] = true;
        votes[candidate]+=1;
        if(votes[candidate]==5){
            votingDone = true;
            winner = candidate;
            winnerAnnounced = true;
        }
    }

    function getWinner() public view returns (address) {
        // Write your code here
        require(winnerAnnounced,"Winner not announced yet");
        return winner;
    }

    function claimReward() public {
        // Write your code here
        require(winnerAnnounced,"Winner not Announced yet!");
        require(msg.sender == winner,"You are not the winner");
        require(!paymentDone,"You have alredy been paid");
        paymentDone = true;
        (bool sent,) = payable(winner).call{value:3 ether}("");
        require(sent,"Transaction falied");
    }

    function collectFees() public {
        // Write your code here
        require(msg.sender==owner,"unauthorized");
        require(paymentDone,"Winner has not collected rewards yet");
        selfdestruct(payable(owner));
    }
}
