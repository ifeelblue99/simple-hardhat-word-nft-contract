// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract WordNFTContract {
    address public contractMinter;
    uint256 public NFT_count = 13;

    struct WordNFT {
        uint256 indx;
        address payable owner;
        string content;
        uint256 mintTime;
        string author;
        uint256 price;
    }
    mapping(uint256 => WordNFT) public NFTsMap;

    constructor() {
        contractMinter = msg.sender;
    }

    error InvalidParamaters();
    event NFTMinted(uint256 _index, address _owner, uint256 _price);
    modifier onlyContractMinter() {
        require(
            msg.sender == contractMinter,
            "Only contract minter can do that..."
        );
        _;
    }
    modifier onlyNftOwner(address _owner) {
        require(msg.sender == _owner, "Only contract minter can do that...");
        _;
    }

    function mintWordNFT(
        string memory _content,
        string memory _author,
        uint256 _price
    ) public {
        if (_price <= 0) {
            revert InvalidParamaters();
        }
        NFTsMap[NFT_count] = WordNFT(
            NFT_count,
            payable(msg.sender),
            _content,
            block.timestamp,
            _author,
            _price
        );
        emit NFTMinted(NFT_count, msg.sender, _price);
        NFT_count = NFT_count + 1;
    }
}
