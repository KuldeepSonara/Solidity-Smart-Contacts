// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import  "./PriceConverter.sol";
//762,021
error NotOwner(string msg);
// error NoValueSent(string msg); 
// error MinimumUSD(string msg);
// error Callfaile(string msg);

contract FundMe {
    using PriceConverter for uint;
    uint public constant MINIMUM_USD = 5e18; //1e18 == 1 * 10 ** 18 == 1000000000000000000wei == 1eth 
    
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }
    address[] public founders;

    mapping (address => uint) public addressToAmountFunded;

    modifier onlyOwner(){
        if(msg.sender != i_owner){
            revert NotOwner("Not the owner");
        }
        _;
    }


    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't Send Enough");


        founders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }

    // main function
    // owner of smart contract can withdraw money
    function withdraw() public {

        for(uint founderIndex = 0; founderIndex < founders.length; founderIndex++){
            address founder = founders[founderIndex];
            addressToAmountFunded[founder] = 0;
        }

        founders = new address[](0);
        //three way to send ether or money transfer , send, call
       
        //transfer
        // payable(msg.sender).transfer(address(this).balance);

        // //send
        // bool sendSuccess=payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send Failed");

        //call
        //we use use call most reloble mathod and mostly used
        (bool callSuccess,)= payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Failed to Withdraw");
    }
}
