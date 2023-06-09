// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./ERC20.sol";

contract DiscreteStakingRewards{
    ERC20 public immutable stakingToken;
    ERC20 public immutable rewardToken;

    mapping(address => uint)public balanceOf;
    uint public totalSupply;

    uint private constant MULTIPLIER = 1e18;
    uint private rewardIndex;
    mapping(address => uint)private rewardIndexOf;
    mapping(address => uint)private earned;


    constructor(address _stakingToken,address _rewardToken){
        stakingToken = ERC20(_stakingToken);
        rewardToken = ERC20(_rewardToken);
    }
    function updateRewardIndex(uint reward)external{
        rewardToken.transferFrom(msg.sender,address(this),reward);
        rewardIndex +=(reward * MULTIPLIER)/totalSupply;
    }
    function _calculateRewards(address account)private view returns(uint){
        uint shares = balanceOf[account];
        return(shares * (rewardIndex - rewardIndexOf[account]))/MULTIPLIER;

    }
    function calculateRewardsEarned(address account)external view returns(uint){
        return earned[account] + _calculateRewards(account);
    }
    function _updateRewards(address account)private{
        earned[account] += _calculateRewards(account);
        rewardIndexOf[account] = rewardIndex;
    }
    function stake()external{
        _updateRewards(msg.sender);
    }
    function unstake()external{
       _updateRewards(msg.sender);
    }
    function claim()external{
        _updateRewards(msg.sender);
    }
}