// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.7.0 <0.9.0;
 contract HelloWorld {
    uint number;
    function set(uint num) public {
        number = num;
    }
    function get() public view returns(uint){
        return number;
    }
 }