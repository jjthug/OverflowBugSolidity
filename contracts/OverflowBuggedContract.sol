//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0; //since 0.8 has safeMath built-in

import "hardhat/console.sol";

contract OverflowBugged {
    mapping (address => uint8) public balances;

    function addBalance(uint8 amount) external{
        balances[msg.sender] += amount;
    }

    function getBalance() external returns(uint8){
        return balances[msg.sender];
    }


    function batchTransfer(address[] calldata receivers, uint8 value) public {
        uint8 amount = uint8(receivers.length) * value;
        require(value > 0 && balances[msg.sender] >= amount);
        
        balances[msg.sender] -= amount;
        //transfer to the batch
        for(uint i=0; i<receivers.length-1; i++){
            balances[receivers[i]] += value;
            //receivers[i].call{value: value}("");
        }

    }
}
