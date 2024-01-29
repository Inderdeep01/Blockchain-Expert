// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <=0.8.17;

contract FizzBuzz {
    event Fizz(address sender, uint indexed count);
    event Buzz(address sender, uint indexed count);
    event FizzAndBuzz(address sender, uint indexed count);
    uint256 private counter;
    function increment() public {
        // Write your code here
        counter++;
        if(counter%15==0){
            emit FizzAndBuzz(msg.sender,counter);
        }
        else if(counter%5==0){
            emit Buzz(msg.sender,counter);
        }
        else if(counter%3==0){
            emit Fizz(msg.sender,counter);
        }
    }
}
