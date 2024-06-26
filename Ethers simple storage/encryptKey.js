const ethers = require("ethers");
const fs = require("fs");
require("dotenv").config();

async function main() {
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY);

    const encryptedKey = await wallet.encrypt(
        process.env.PRIVATE_KEY,
        process.env.PRIVATE_KEY_PASS,
    );

    console.log(encryptedKey);
    fs.writeFileSync("./.encryptedKey.json", encryptedKey);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    });
