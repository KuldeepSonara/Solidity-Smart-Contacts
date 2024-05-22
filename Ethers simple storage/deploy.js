const { ethers } = require("ethers");
require("dotenv").config();

const fs = require("fs-extra");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

    // const encryptedJson = fs.readFileSync("./.encryptedKey.json", "utf-8");
    // let wallet = new ethers.Wallet.fromEncryptedJsonSync(
    //   encryptedJson,
    //   process.env.PRIVATE_KEY_PASS
    // );
    // wallet = wallet.connect(provider);
    const abi = fs.readFileSync(
        "./SimpleStorage_sol_SimpleStorage.abi",
        "utf-8",
    );
    const bytecode = fs.readFileSync(
        "./SimpleStorage_sol_SimpleStorage.bin",
        "utf-8",
    );

    const contractFactory = new ethers.ContractFactory(abi, bytecode, wallet);
    console.log("Deploying, please wait...");
    const contract = await contractFactory.deploy();
    const deploymentReceipt = await contract.deployTransaction.wait(1);

    console.log(`contarct addres : ${contract.address}`);
    const curentFavriteNumber = await contract.retrieve();
    console.log(`Curent Favrite Number : ${curentFavriteNumber.toString()}`);
    const tranactionRespons = await contract.store("7");
    const transctionReceipt = await tranactionRespons.wait(1);
    const updatedFavoriteNumber = await contract.retrieve();
    console.log(`curent favorite number : ${updatedFavoriteNumber.toString()}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
