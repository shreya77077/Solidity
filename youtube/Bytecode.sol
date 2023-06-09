//SPDX-Lisence-Idnetifier: MIT
pragma solidity ^0.8.17;

//Runtime code
//creation code
//Factory contract

contract Factory{
    function deploy() external{
        bytes memory bytecode = hex "69602a60005260206000f360005260206000f3"; //38/2=19
        address addr;
        assembly{
            addr := create (0,addr(bytecode,0x20), 0x13) // 19= 0x19
        }
        require(addr != address(0),"deploy failed");

        emit Log(addr);
    }
}
interference IContract{
    function getMeaningOfLife() external view returns(uint);
}

/*
Store 42 to memory
mstore(p,v) - store v at moment p to p +32

PUSH1 0x2a
PUSH1 0
MSTORE

(always return 42)
return(p,s) - end execution and return data from memory p to p + s

Return 32 bytes from memory
PUSH1 0x20
PUSH1 0
RETURN

PUSH1 0x2a
PUSH1 0
MSTORE

PUSH1 0x20
PUSH1 0
RETURN

Run time code - return 42
602a60005260206000f3
*/

/*
Creation code
Store run time code to memory

PUSH10 0x602a6000526000f3
PUSH1 0
MSTORE

0x0000000000000000000000602a6000526000f3

Return 10 bytes from memory starting at offset 22

PUSH1 0x0a
PUSH1 0x16
RETURN
69602a60005260206000f360005260206000f3

 */

