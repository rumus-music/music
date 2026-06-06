// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IToken {
    function transfer(
        address to,
        uint256 amount
    ) external returns(bool);
}

contract Faucet {

    IToken public token;

    uint256 public dripAmount =
        100 * 10**18;

    mapping(address => uint256)
        public lastClaim;

    constructor(address tokenAddress) {
        token = IToken(tokenAddress);
    }

    function claim() external {

        require(
            block.timestamp >
            lastClaim[msg.sender] + 1 days,
            "Wait 24h"
        );

        lastClaim[msg.sender] =
            block.timestamp;

        token.transfer(
            msg.sender,
            dripAmount
        );
    }
}
