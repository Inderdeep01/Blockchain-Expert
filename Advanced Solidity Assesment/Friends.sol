pragma solidity >=0.4.22 <=0.8.17;

contract Friends {
    modifier noReqSent(address friend){
        // check if request is already sent
        require(!users[msg.sender].isRequestSent[friend], "Request Already sent");
        _;
    }

    modifier noLoop(address friend){
        require(msg.sender != friend, "Cannot send request to oneself");
        _;
    }

    modifier notAlreadyFriends(address friend){
        // check if user is already friend
        require(!users[msg.sender].isFriends[friend], "Already friends");
        _;
    }

    modifier noRequestRecieved(address friend){
        // check if user has recieved request from the friend already
        require(!users[msg.sender].isRequestRecieved[friend], "friend has already sent you request");
        _;
    }

    struct User {
        address[] requestsRecieved;
        address[] friends;
        address[] requestSent;
        mapping (address=>bool) isFriends;
        mapping (address=>bool) isRequestSent;
        mapping (address=>bool) isRequestRecieved;
    }

    mapping(address=>User) users;

    function getFriendRequests() public view returns (address[] memory){
        return users[msg.sender].requestsRecieved;
    }

    function getNumberOfFriends() public view returns (uint){
        return users[msg.sender].friends.length;
    }

    function getFriends() public view returns (address[] memory){
        return users[msg.sender].friends;
    }

    function sendFriendRequest(address friend) public noLoop(friend) noReqSent(friend) notAlreadyFriends(friend) noRequestRecieved(friend) {
        users[msg.sender].isRequestSent[friend] = true;
        users[msg.sender].requestSent.push(friend);
        users[friend].requestsRecieved.push(msg.sender);
        users[friend].isRequestRecieved[msg.sender] = true;
    }

    function acceptFriendRequest(address friend) public {
        require(users[msg.sender].isRequestRecieved[friend], "No such request found");
        require(!users[msg.sender].isFriends[friend], "Already friends");
        // Add to friends list
        users[msg.sender].isFriends[friend] = true;
        users[msg.sender].friends.push(friend);
        users[friend].friends.push(msg.sender);
        users[friend].isFriends[msg.sender] = true;
        // Remove from requests recieved
        uint n = users[msg.sender].requestsRecieved.length;
        for(uint i;i<n;i++){
            if(users[msg.sender].requestsRecieved[i]==friend){
                users[msg.sender].requestsRecieved[i] = users[msg.sender].requestsRecieved[n-1];
                delete users[msg.sender].requestsRecieved[n-1];
                users[msg.sender].requestsRecieved.pop();
            }
        }
    } 
}
