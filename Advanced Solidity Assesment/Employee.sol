pragma solidity >=0.4.22 <=0.8.17;

enum Department {
    Gardening, Clothing, Tools
}

contract Employee {
    string fName;
    string lName;
    uint hourlyPay;
    Department department;

    constructor(string memory _fName, string memory _lName, uint _hourlyPay, Department _department)  {
        fName = _fName;
        lName = _lName;
        hourlyPay = _hourlyPay;
        department = _department;
    }

    function getWeeklyPay(uint _hours) public view returns (uint){
        uint salary;
        if(_hours>40){
            uint overTime = _hours-40;
            uint normal = _hours-overTime;
            salary = normal*hourlyPay;
            salary += overTime*hourlyPay*2;
        } else {
            salary = _hours*hourlyPay;
        }
        return salary;
    }

    function getFirstName() public view returns(string memory){
        return fName;
    }
}

contract Manager is Employee {
    Employee[] subordinates;

    constructor(string memory _fName, string memory _lName, uint _hourlyPay, Department _department) Employee(_fName, _lName, _hourlyPay, _department){}

    function addSubordinate(string memory _fName, string memory _lName, uint _hourlyPay, Department _department) public{
        subordinates.push(new Employee(_fName, _lName, _hourlyPay, _department));
    }

    function getSubordinates() public view returns (string[] memory){
        uint n = subordinates.length;
        string[] memory names = new string[](n);
        for(uint i;i<n;i++){
            names[i] = subordinates[i].getFirstName();
        }
        return names;
    }
}