pragma solidity >=0.4.22 <=0.8.17;

contract DebtTracking {
    // Write your code here
    mapping(address => mapping(address=>uint)) owing;

    function addDebt(
        address owedAdress,
        address owingAddress,
        uint256 amount
    ) public {
        uint debt = owing[owedAdress][owingAddress];
        if(debt==0){
            owing[owedAdress][owingAddress] = amount;
        }
        else{
            debt = debt+amount;
            owing[owedAdress][owingAddress] = debt;
        }
    }

    function payDebt(
        address owedAdress,
        address owingAddress,
        uint256 amount
    ) public {
        uint debt = owing[owedAdress][owingAddress];
        if(amount<=debt){
            debt = debt - amount;
            owing[owedAdress][owingAddress] = debt;
        }
        else{
            debt = amount - debt;
            owing[owingAddress][owedAdress] = debt;
        }
    }

    function getDebt(address owedAddress, address owingAddress)
        public view
        returns (uint256)
    {
        return owing[owedAddress][owingAddress];
    }
}
