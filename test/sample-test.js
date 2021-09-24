const { BigNumber } = require("@ethersproject/bignumber");
const { expect } = require("chai");
const TheContract = artifacts.require("OverflowBugged");

describe("BuggedContract", (accounts) => {
  let buggedContract;
  before(async ()=>{
    accounts = await web3.eth.getAccounts();
    buggedContract = await TheContract.new();
  })
  
  it("Should return the new greeting once it's changed", async () => {


    await buggedContract.addBalance(10);
    await buggedContract.batchTransfer([accounts[1],accounts[2]], 128);

    let balance = await buggedContract.getBalance({from: accounts[2]});
    assert(balance, 128);


  })
})
