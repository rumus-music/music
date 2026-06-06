require("dotenv").config();

const TronWeb = require("tronweb");

const tronWeb = new TronWeb({
  fullHost: process.env.FULL_HOST,
  privateKey: process.env.PRIVATE_KEY
});

async function main() {

  const staking =
    await tronWeb.contract()
      .at(process.env.STAKING_ADDRESS);

  const tx =
    await staking.claim().send();

  console.log(tx);
}

main();
