pragma solidity >=0.4.22 <=0.8.17;

contract ShoppingList {
    // Write your structs here
    struct Item {
        string name;
        uint qty;
    }

    struct List {
        string name;
        Item[] items;
    }

    mapping (address => List[]) lists;

    function createList(string memory name) public {
        require(bytes(name).length>0, "No name provided");
        bool exists;
        uint listSize = lists[msg.sender].length;
        for (uint i; i<listSize;i++){
            if ( keccak256(abi.encodePacked((lists[msg.sender][i].name))) == keccak256(abi.encodePacked((name)))){
                exists = true;
            }
        }
        require(!exists, "List already exists");
        List memory l;
        Item[] memory i;
        l.name = name;
        l.items = i;
        lists[msg.sender].push(l);
    }

    function getListNames() public view returns (string[] memory) {
        // Write your code here
        uint n = lists[msg.sender].length;
        string[] memory res = new string[](n);
        for (uint i; i<n; i++){
            res[i] = lists[msg.sender][i].name;
        }
        return res;
    }

    function getItemNames(string memory listName) public view returns (string[] memory){
        require(bytes(listName).length>0, "No name provided");
        bool exists;
        uint listSize = lists[msg.sender].length;
        uint listIdx;
        for (uint i; i<listSize;i++){
            if ( keccak256(abi.encodePacked((lists[msg.sender][i].name))) == keccak256(abi.encodePacked((listName)))){
                exists = true;
                listIdx = i;
            }
        }
        require(exists, "List does not exists");
        uint numItems = lists[msg.sender][listIdx].items.length;
        string[] memory items = new string[](numItems);
        for(uint i; i<numItems; i++){
            items[i] = lists[msg.sender][listIdx].items[i].name;
        }
        return items;
    }

    function addItem( string memory listName, string memory itemName, uint256 quantity) public {
        require(bytes(listName).length>0, "No name provided");
        require(bytes(itemName).length>0, "No item name provided");
        bool exists;
        uint listSize = lists[msg.sender].length;
        uint listIdx;
        for (uint i; i<listSize;i++){
            if ( keccak256(abi.encodePacked((lists[msg.sender][i].name))) == keccak256(abi.encodePacked((listName)))){
                exists = true;
                listIdx = i;
            }
        }
        require(exists, "List does not exists");
        //Item memory item = Item(itemName, quantity);
        lists[msg.sender][listIdx].items.push(Item(itemName, quantity));
    }
}
