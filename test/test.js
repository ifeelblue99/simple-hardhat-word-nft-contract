const { chai, expect } = require("chai");
const { ethers } = require("hardhat");

describe("should return error due to invalid unction args", function () {
  it("price: 0", async () => {
    const WordNFTContract = await ethers.getContractFactory("WordNFTContract");
    const wordNFT = await WordNFTContract.deploy();
    await wordNFT.deployed();
    try {
      await wordNFT.mintWordNFT("content", "author", 0);
    } catch (error) {
      expect(error.message).to.equal(
        "VM Exception while processing transaction: reverted with custom error 'InvalidParamaters()'"
      );
    }
  });
});
describe("should return error due to invalid unction args", function () {
  it("price: <0", async () => {
    const WordNFTContract = await ethers.getContractFactory("WordNFTContract");
    const wordNFT = await WordNFTContract.deploy();
    await wordNFT.deployed();
    try {
      await wordNFT.mintWordNFT("content", "author", -10);
    } catch (error) {
      expect(error.message).to.equal(
        `value out-of-bounds (argument="_price", value=-10, code=INVALID_ARGUMENT, version=abi/5.6.0)`
      );
    }
  });
});

describe("should emit NFTMinted", () => {
  it("emit NFTMinted", async () => {
    const WordNFTContract = await ethers.getContractFactory("WordNFTContract");
    const wordNFT = await WordNFTContract.deploy();
    await wordNFT.deployed();

    await expect(wordNFT.mintWordNFT("content", "author", 10)).to.emit(
      wordNFT,
      "NFTMinted"
    );
  });
});
