const hre = require("hardhat");

async function main() {
  
  const TEST = await hre.ethers.getContractFactory("UMA");
  const test = await TEST.deploy();

  await test.deployed();

  console.log("deployed to:", test.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });