// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract FuncModifier{
    //Examples
    //1. Restricting write access(basic syntax)
    //2. Validate inputs(inputs,why useful?)
    //3. Reentrancy guard(reentrancy hack)

    address public owner;

    constructor() public { 
        owner = msg.sender;

    }
 modifier onlyOwner(){
        require(msg.sender == owner, "Not owner");
        _;
    }    
    modifier validAddress(address _addr){
        require(_addr !=address(0),"Not valid address");
        _;
    }

 function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner){
        owner = _newOwner;
    }
//    function changeOwner(address _newOwner)public{
//         onlyOwner();
//         validAddress(_newOwner);

//         owner = _newOwner;
    
//     }
}