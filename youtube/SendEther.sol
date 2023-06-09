//SPDX-License-Identifier:MIT

pragma solidity ^0.8.17;
/*
3 ways to send ether from a contract to another contract
-transfer(forwards 2300 gas,throws error)
-send (forwards 2300 gas,rerurns bool)
*/

contract ReceiveEther{
    function() external payable{}

    function getBalance() public view returns (uint){
        return sddress(this).balance;

    }
}

contract SendEther{
    function sendViaTransfer(address payable _to)public payable{
        _to.transfer(msg.value);
    }
    function sendViaSend(address payable _to) public payable{
        bool sent = _to.send(msg.value);
        require(sent,"Failed to send Ether");
    }
    function snedViaCall(address payable _to)public payable{
        _to.call.value(msg.value)(" ");
    }
}

