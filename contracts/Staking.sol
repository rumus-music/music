// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITRC20 {

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns(bool);

    function transfer(
        address to,
        uint256 amount
    ) external returns(bool);
}

contract Staking {

    ITRC20 public token;

    uint256 public rewardRate =
        1e16;

    struct StakeInfo {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => StakeInfo)
        public stakes;

    constructor(address tokenAddress) {
        token = ITRC20(tokenAddress);
    }

    function stake(
        uint256 amount
    ) external {

        token.transferFrom(
            msg.sender,
            address(this),
            amount
        );

        stakes[msg.sender] =
            StakeInfo(
                amount,
                block.timestamp
            );
    }

    function pendingReward(
        address user
    ) public view returns(uint256){

        StakeInfo memory s =
            stakes[user];

        if(s.amount == 0)
            return 0;

        uint256 timePassed =
            block.timestamp -
            s.timestamp;

        return
            (s.amount *
             rewardRate *
             timePassed)
             / 1e18;
    }

    function claim() external {

        uint256 reward =
            pendingReward(msg.sender);

        stakes[msg.sender]
            .timestamp =
            block.timestamp;

        token.transfer(
            msg.sender,
            reward
        );
    }
}
