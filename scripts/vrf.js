const hre = require("hardhat");

async function main() {

  const subscription_id= ''

  const TEST = await hre.ethers.getContractFactory("VRFv2Consumer");
  const test = await TEST.deploy(subscription_id);

  await test.deployed();

  console.log("deployed to:", test.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });