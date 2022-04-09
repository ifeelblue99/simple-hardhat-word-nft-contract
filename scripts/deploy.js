const hre = require("hardhat");

async function main() {
  const WordNFTContract = await hre.ethers.getContractFactory(
    "WordNFTContract"
  );
  const wordNFT = await WordNFTContract.deploy();

  await wordNFT.deployed();

  console.log("WordNFT deployed to:", wordNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
