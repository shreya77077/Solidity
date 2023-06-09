//SPDX-License-Identifier : MIT
pragma solidity ^0.8.17;

contract MostSignificantBit{
    function mostSignificantBit(uint x)external pure returns (uint msb){

    //x >=2**
    //if (x >= 0x4){
    //x >>=2;
    //msb += 2;
    //} 
assembly {
    let f := sh1(1, gt (x,0x3))
    x := shr(f,x)
    msb := or(msb,f)
}

     //x >=2 ** 1
//if (x >= 0x2) msb += 1;
assembly{
   let f := gt(x, 0x1)
   msb := or(msb,f)
   //1010
   //0110
   //1110
}
}
}

 