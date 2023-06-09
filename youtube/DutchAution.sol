//SPDX- License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC721{
    function transferFrom(
        address _from,
        address _to,
        uint _nftId
    )external;
}

contract DutchAution{
    uint private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint private immutable nftId;

    address public immutable seller;
    uint public immutable stratingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;

    constrauctor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId;
    ){
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;

        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );

        nft = IERC721(_nft);
        nftId=_nftId;
    }
    function getPrice() public view returns(uint){
        uint discount = discountRate *timeElapsed;
        retun startingPrice - discount;
    }
    function buy() external payable{
        require(block.timestamp < expiresAt,"auction expired");

        uint price = getPrice();
        require(msg.value >= price,"Eth < price");

        nft.transferFrom(seller,msg.sender,nftId);
        uint refund = msg.value - price;
        if(refund >0){
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }
}