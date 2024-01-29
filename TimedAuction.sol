pragma solidity >=0.4.22 <=0.8.17;

contract TimedAuction {
    // Declare your event(s) here
    uint expiry;
    event Bid(address indexed sender, uint amount, uint timestamp);
    mapping(address=>uint) bids;
    uint private highestBid;
    address private owner;
    address private highestBidder;
    uint private balance;
    
    constructor(){
        expiry = block.timestamp+ 5 minutes;
        owner = msg.sender;
    }

    function bid() external payable {
        // Write your code here
        require(msg.value>highestBid, "C'mmon looser, bid more");
        require(block.timestamp<expiry, "Auction closed for bids");
        bids[msg.sender] += msg.value;
        highestBidder = msg.sender;
        highestBid = msg.value;
        balance += msg.value;
        emit Bid(msg.sender, msg.value, block.timestamp);
    }

    function withdraw() public {
        // Write your code here
        require(bids[msg.sender]!=highestBid,"highest bid cannot be withdrwan");
        
        uint amt = 0;
        if (msg.sender==highestBidder){
            amt = bids[msg.sender] - highestBid;
        }
        else {
            amt = bids[msg.sender];
        }
        balance -= amt;
        bids[msg.sender] -= amt;
        (bool sent,) = payable(msg.sender).call{value:amt}("");
        require(sent, "Error sending funds");
    }

    function claim() public {
        // Write your code here
        require(block.timestamp>expiry,"Auction going on");
        require(balance-highestBid==0, "Highest bidder has not reclaimed unsused amt");
        require(msg.sender==owner, "Not an owner");
        selfdestruct(payable(owner));
    }

    function getHighestBidder() public view returns (address) {
        // Write your code here
        return highestBidder;
    }
}
