// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

contract WordNFTContract {
    address public contractMinter;
    uint public NFT_count = 13;

    struct WordNFT {
        uint indx;
        address payable owner;
        string content;
        uint mintTime;
        string author;
        uint price;
    }
    mapping(uint=>WordNFT) public NFTsMap;
    WordNFT[] nftArray;

    constructor(){
        contractMinter = msg.sender;
    }
    error InvalidParamaters();
    event NFTMinted(uint _index, address _owner, uint _price);
    modifier onlyContractMinter{
        require(msg.sender==contractMinter, "Only contract minter can do that...");
        _;
    }
    modifier onlyNftOwner(address _owner){
        require(msg.sender==_owner, "Only contract minter can do that...");
        _;
    }
    function mintWordNFT(string memory _content, string memory _author, uint _price) public {
        if(_price<=0){
            revert InvalidParamaters();
        }  
        nftArray.push(WordNFT (NFT_count ,payable(msg.sender),_content,block.timestamp,_author,_price));
        NFTsMap[NFT_count] = WordNFT (NFT_count ,payable(msg.sender),_content,block.timestamp,_author,_price);
        emit NFTMinted(NFT_count, msg.sender, _price);
        NFT_count = NFT_count + 1;
    }
    function getNFTs() public view returns(WordNFT[] memory) {
        return nftArray;
    }
}