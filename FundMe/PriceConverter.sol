// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
      function getPrice() internal view returns(uint){
        //ABI
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         (,int256 price,,,) = priceFeed.latestRoundData(); // ETH to USD
        // we return in 3000.00000000
         return uint(price * 1e10); // 1**10 == 10000000000
    }

    function getConversionRate(uint ethAmount) internal view returns(uint) {
        uint ethPrice = getPrice();
        uint ethAmountInUsd = (ethPrice * ethAmount) / 1e18;

        return ethAmountInUsd;
    }

    function getVrsion() internal view returns(uint) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}