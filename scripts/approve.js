require("dotenv").config();

const TronWeb = require("tronweb");

const tronWeb = new TronWeb({
  fullHost: process.env.FULL_HOST,
  privateKey: process.env.PRIVATE_KEY
});

async function main() {

  const token =
    await tronWeb.contract()
      .at(process.env.TOKEN_ADDRESS);

  const amount =
    tronWeb.toBigNumber(
      "100000000000000000000"
    );

  const tx =
    await token.approve(
      process.env.STAKING_ADDRESS,
      amount
    ).send();

  console.log(tx);
}

main();
