pragma solidity >=0.4.22 <=0.8.17;

contract ShoppingList {
    mapping (address=>User) users;

   struct User {
    mapping (string=>List) lists;
    string[] listNames;
   }

   struct Item {
    string name;
    uint quantity;
   }

   struct List {
    string name;
    Item[] items;
   }

    function listExists(string memory name) internal view returns (bool){
        return bytes(users[msg.sender].lists[name].name).length !=0;
    }

    function createList(string memory name) public {
        require(bytes(name).length>0, "No name provided");
        require(!listExists(name), "already exist");
        users[msg.sender].listNames.push(name);
        users[msg.sender].lists[name].name = name;
    }

    function getListNames() public view returns (string[] memory) {
        return users[msg.sender].listNames;
    }

    function getItemNames(string memory listName) public view returns (string[] memory){
        require(listExists(listName));
        string[] memory names = new string[](users[msg.sender].lists[listName].items.length);
        for (uint256 idx = 0; idx < names.length; idx++) {
            names[idx] = users[msg.sender].lists[listName].items[idx].name;
        }
        return names;
    }

    function addItem( string memory listName, string memory itemName, uint256 quantity) public {
        require(listExists(listName));
        users[msg.sender].lists[listName].items.push(Item(itemName, quantity));
    }
}
