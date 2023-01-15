pragma solidity >=0.4.22 <=0.8.17;

contract LargestHolder {
    //storage variables 
    uint[] balances;
    address[] holders;

    //flag variables
    bool balancesRecieved = false;
    bool largestHolderFound = false;

    //Iteration Helpers
    uint arrayLength;
    uint traversed;
    uint txRequired;

    // data holders
    address largestHolder;
    address secondLargest;
    uint largestBalance;
    uint largestBalance2;

    function submitBalances(
        uint256[] memory _balances,
        address[] memory _holders
    ) public {
        // Write your code here
        balancesRecieved = true;
        arrayLength = _balances.length;
        for(uint i;i<arrayLength;i++){
            balances.push(_balances[i]);
            holders.push(_holders[i]);
        }
        if(arrayLength%10==0){
            txRequired = arrayLength/10;
        }
        else{
            txRequired = (arrayLength/10) + 1;
        }
    }

    function process() public {
        // Write your code here
        require(balancesRecieved,"Wait until balances are submitted");
        require(txRequired>0,"All operations completed");
        uint idx = traversed;
        for(uint itr;itr<10;itr++){
            if(balances[idx]>largestBalance){
                largestBalance = balances[idx];
                largestHolder = holders[idx];
            }
            else if(balances[idx]>largestBalance2 && balances[idx]<largestBalance){
                largestBalance2 = balances[idx];
                secondLargest = holders[idx];
            }
            idx++;
        }
        traversed+=10;
        txRequired-=1;
        if(txRequired==0){
            largestHolderFound = true;
        }
    }

    function numberOfTxRequired() public view returns (uint256) {
        // Write your code here
        require(balancesRecieved,"Wait until balances are submitted");
        return txRequired;
    }

    function getLargestHolder() public view returns (address) {
        // Write your code here
        require(balancesRecieved,"Wait until balances are submitted");
        require(largestHolderFound,"Largest Holder not found yet");
        return largestHolder;
    }
}
