const { ethers } = require("ethers");

const RPC_URL = "https://go.getblock.io/eac5f354fbd947789cc7d6b299091b47/";
const PRIVATE_KEY = "gb_645ca8a90df2934c481eb679";

const provider = new ethers.JsonRpcProvider(RPC_URL);
const wallet = new ethers.Wallet(PRIVATE_KEY, provider);

async function sendFaucet(receiver) {
    const tx = await wallet.sendTransaction({
        to: receiver,
        value: ethers.parseEther("0.001")
    });

    await tx.wait();
    return tx.hash;
}
