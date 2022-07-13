const hre = require("hardhat");
const { ethers } = require("ethers");
const sleep = ms => new Promise(res => setTimeout(res, ms));

const provider = new ethers.providers.JsonRpcProvider("https://rpc-mumbai.maticvigil.com");
const link_abi = [
    "function transfer(address,uint256) external returns (bool)"
  ]
const link_address = "0x326C977E6efc84E512bB9C30f76E30c160eD06FB"; //for mumbai network
const tokenContract = new ethers.Contract(link_address, link_abi, provider);
const privateKey = "";
const wallet = new ethers.Wallet(privateKey, provider);
const link = tokenContract.connect(wallet);



async function main() {

  const TEST = await hre.ethers.getContractFactory("APIConsumer");
  const test = await TEST.deploy();

  await test.deployed();

  console.log("deployed to:", test.address);

  console.log("sending link to contract" )
  const tx= await link.transfer(test.address,ethers.utils.parseEther("0.1"));
  await tx.wait();

  console.log("call requestPrice function to get price")
  const request= await test.requestPriceData();
  await request.wait();

  console.log("getting price..")
  await sleep(10000); //10 second delay to settle transaction
  const price= await test.get_price();
  console.log("price: ", price)


}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });