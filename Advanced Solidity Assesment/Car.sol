pragma solidity >=0.4.22 <=0.8.17;

enum Engine{
    Stop, Start
}

interface Driveable {
    function startEngine() external ;
    function stopEngine() external ;

    function fuelUp(uint liters) external;
    function drive(uint kms) external;
    function kilometersRemaining() external view returns(uint);
}

abstract contract GasVehicle is Driveable {
    modifier ON{
        require(engine==Engine.Start);
        _;
    }
    modifier OFF{
        require(engine==Engine.Stop);
        _;
    }
    Engine engine;
    uint milage;
    uint fuel;
    uint tankCapacity;

    function startEngine() public override {
        engine = Engine.Start;
    }
    function stopEngine() public override {
        engine = Engine.Stop;
    }

    function fuelUp(uint l) public override OFF {
        require(fuel+l<=tankCapacity, "Overloading tank");
        fuel += l;
    }

    function drive(uint kms) public override ON {
        require(milage*fuel>=kms, "Insufficient gas");
        uint fuelUsed = kms/milage;
        fuel-= fuelUsed;
    }

    function kilometersRemaining() public view override returns(uint){
        return milage*fuel;
    }

    function getKilometersPerLitre() public view virtual returns(uint);
    function getFuelCapacity() public view virtual returns(uint);
}

contract Car is GasVehicle {

    constructor(uint _tankSize, uint _milage){
        tankCapacity = _tankSize;
        milage = _milage;
    }

    function getKilometersPerLitre() public override view returns (uint){
        return milage;
    }

    function getFuelCapacity() public override view returns(uint){
        return tankCapacity;
    }
}
