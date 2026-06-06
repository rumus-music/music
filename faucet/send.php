<?php

$config = require 'config.php';

$receiver = trim($_POST['address']);

if (!preg_match('/^0x[a-fA-F0-9]{40}$/', $receiver)) {
    die("Alamat wallet tidak valid");
}

echo "Permintaan diterima.<br>";
echo "Kirim {$config['amount_eth']} ETH ke:<br>";
echo htmlspecialchars($receiver);

/*
Untuk produksi Anda perlu:

1. Membuat transaksi raw
2. Menandatangani transaksi menggunakan private key
3. Mengirim via eth_sendRawTransaction
4. Menyimpan log klaim
5. Membatasi klaim per IP/wallet
6. Menambahkan CAPTCHA

Biasanya lebih mudah menggunakan backend Node.js + ethers.js
untuk proses signing transaksi EVM.
*/
