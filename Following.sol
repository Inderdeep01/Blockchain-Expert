pragma solidity >=0.4.22 <=0.8.17;

contract Following {
    // Write your code here
    mapping(address=>address[]) private followers;

    function follow(address toFollow) public{
        require(toFollow!=tx.origin,"Invalid address");
        require(followers[msg.sender].length<3,"You can not follow more addresses");
        followers[msg.sender].push(toFollow);
    }

    function getFollowing(address addr) external view returns(address[] memory){
        uint n = followers[addr].length;
        address[] memory fans = new address[](n);
        fans = followers[addr];
        return fans;
    }

    function clearFollowing() external{
        uint n = followers[msg.sender].length;
        while(n!=0){
            followers[msg.sender].pop();
            n--;
        }
    }
}
