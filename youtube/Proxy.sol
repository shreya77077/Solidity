//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TestContract1{
    address public owner = msg.sender;

    function setOwner(address _owner) public{
        require(msg.sender == owner,"not owner");
        owner = _owner;
    }

}
contract TestContract2{
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x,uint _y)payable{
        x = _x;
        y = _y;
    }

}

contract Proxy{
    event Deploy(address);
    function deploy(bytes memory _code)external payable returns (address addr){
        assembly{
            //create(v,p,n)
            //v = amount of Eth to send
            //p = pointer in memory to start of code
            //n = size of code
            addr := create(callvalue(),add(_code,0x20),mload(_code))

        }
        require(addr != address(0),"deploy failed");
        //new TestContract();
        emit Deploy(addr);
    }
    function execute (address _target,bytes memory _data)external payable{
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success,"failed");
    }
}
//what is bytecode

contract Helper{
    function getBytecode1() external pure retunrs (bytes memory){
        bytes memory bytecode = type(TestContract1).createCode;
        return bytecode;
    }
    function getBytecode2(uint _x,uint _y) external pure retunrs (bytes memory){
        bytes memory bytecode = type(TestContract2).createCode;
        return abi.encode(bytecode,abi.encode(_x,_y));
    }
    function getBytecode1() external pure retunrs (bytes memory){
        bytes memory bytecode = type(TestContract1).createCode;
        return abi.encodeWithSignature("setOwner(address)",_owner);
    }
}


