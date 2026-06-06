// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DappMiner {
    string public constant NAME = "DappMiner";
    string public constant SYMBOL = "DMT";

    address public owner;
    uint256 public stakingAPY = 12;
    uint256 public marketplaceFee = 25; // 2.5% = 25/1000
    uint256 public minerReward = 9e16;  // 0.09 token

    mapping(address => bool) public admins;

    event AdminAdded(address indexed admin);
    event AdminRemoved(address indexed admin);
    event RewardClaimed(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "Not admin");
        _;
    }

    constructor(address[] memory initialAdmins) {
        owner = msg.sender;

        for (uint256 i = 0; i < initialAdmins.length; i++) {
            admins[initialAdmins[i]] = true;
        }
    }

    function addAdmin(address admin) external onlyOwner {
        admins[admin] = true;
        emit AdminAdded(admin);
    }

    function removeAdmin(address admin) external onlyOwner {
        admins[admin] = false;
        emit AdminRemoved(admin);
    }

    function claimReward() external {
        emit RewardClaimed(msg.sender, minerReward);
    }

    function transferOwnership(address newOwner)
        external
        onlyOwner
    {
        owner = newOwner;
    }
}
