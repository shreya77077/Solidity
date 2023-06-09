//SPDX - License- Identifier: MIT
pragma solidity ^0.8.17;

contract EthreWallet {
    address payable public owner;

    comstructor() {
        owner = msg.sender;
    }

    recieve() external payable{}

    function withdraw(uint _amount) external{
        require(msg.sender == owner, "caller is not owner");
        owner.transfer(_amount);
    }

}

//========gas optimization ==========//
/*
     function withdraw(uint _amount) external{
       //1.a  require(msg.sender == owner, "caller is not owner");

       //2.a payable(msg.sender).transfer(_amount);

       //1.b (bool sent,)= msg.sender.call{value: _amount}("");
      //2.b  require(sent,"Falied to send Ether");
    }


*/

//full proper code:
contract EthreWallet {
    address payable public owner;

    comstructor() {
        owner = msg.sender;
    }

    recieve() external payable{}

    function withdraw(uint _amount) external{
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }
    function getBalance() external view returns(uint){
        return address(this).balance;
    }

}


