// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockTRC20 {
    string public name = "Mock Token";
    string public symbol = "MTK";
    uint8 public decimals = 18;

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256))
        public allowance;

    constructor(uint256 supply) {
        totalSupply = supply;
        balanceOf[msg.sender] = supply;
    }

    function transfer(
        address to,
        uint256 amount
    ) public returns(bool) {

        require(balanceOf[msg.sender] >= amount);

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        return true;
    }

    function approve(
        address spender,
        uint256 amount
    ) public returns(bool) {

        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns(bool) {

        require(balanceOf[from] >= amount);
        require(
            allowance[from][msg.sender] >= amount
        );

        allowance[from][msg.sender] -= amount;

        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}
