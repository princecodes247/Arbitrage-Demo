// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // Deploy Tokens
  const Token = await hre.ethers.getContractFactory("Token");

  const tokenA = await Token.deploy("TokenA", "TA", 100000000);
  await tokenA.deployed();
  let tokenA_Address= tokenA.address;
  console.log("Token A deployed to: ", tokenA.address);

  const tokenB = await Token.deploy("TokenB", "TB", 100000000);
  await tokenB.deployed();
  let tokenB_Address= tokenB.address;
  console.log("Token B deployed to: ", tokenB.address);

//   Deploy DEX contracts
  const DEX = await hre.ethers.getContractFactory("DEX");

 const NotUniSwap = await DEX.deploy(tokenA_Address, tokenB_Address, 5, 10);
 await NotUniSwap.deployed();
console.log("NotUniSwap deployed to: ", NotUniSwap.address)
let dex1_Address = NotUniSwap.address;
 const NotPancakeSwap = await DEX.deploy(tokenA_Address, tokenB_Address, 5, 9);
 await NotPancakeSwap.deployed();
 console.log("NotPancakeSwap deployed to: ", NotPancakeSwap.address)
 let dex2_Address = NotPancakeSwap.address;


//   Deploy Arbitrage contract
  const Arbitrage = await hre.ethers.getContractFactory("Arbitrage");
  const arbitrage = await Arbitrage.deploy(dex1_Address, dex2_Address, tokenA_Address, tokenB_Address);
  await arbitrage.deployed();
  console.log("Arbitrage deployed to: ", arbitrage.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
