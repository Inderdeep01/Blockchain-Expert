pragma solidity >=0.4.22 <=0.8.17;

contract Item {
    uint price;
    string name;
    constructor(string memory _name, uint _price) {
        price = _price;
        name = _name;
    }
    
    function getName() public view returns(string memory){
        return name;
    }

    function getPrice() public virtual view returns(uint){
        return price;
    }
}

contract TaxedItem is Item{
    uint tax;
    constructor(string memory _name, uint _price, uint _tax) Item(_name, _price){
        tax = _tax;
    }

    function getPrice() public override view returns(uint){
        return price + tax;
    }
}
