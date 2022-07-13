const hre = require("hardhat");

async function main() {

  const tellor_address = " "  
  const TEST = await hre.ethers.getContractFactory("UsingTellor");
  const test = await TEST.deploy(tellor_address);

  await test.deployed();

  console.log("deployed to:", test.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });