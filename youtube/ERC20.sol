// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;


/*
ERC20
-transfer
-approve,allowance,transferForm
*/

interface IERC20{
    function totalSupply() external view returns(uint256);
    function balanceOf(address account)external view returns(uint256);
    function transfer(address recipent,uint256 amount)external returns (bool);
    function allowance(address owner,address spender)external view returns (uint256);
    function approve(address spender,uint256 amount) external returns(bool);
    function transferFrom(address sender,address recipient,uint256 amount)external returns(bool);

    event Transfer(address indexed from , address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender,uint256 value);
}
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    constructor(string memory name, string memory symbol) ERC20(name,symbol) public{
        // 1.00 USD = 100
        _mint(msg.sender,100*10**uint(decimals()));
    }
}
