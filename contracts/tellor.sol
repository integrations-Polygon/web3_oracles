// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "usingtellor/contracts/UsingTellor.sol";

    //network: polygon mumbai
    //testnet address: 0x41b66dd93b03e89D29114a7613A6f9f0d4F40178
    //mainnet address: 0xFd45Ae72E81Adaaf01cC61c8bCe016b7060DD537
    //get query id: https://querybuilder.tellor.io


contract MyContract is UsingTellor {
    constructor(address payable _tellorAddress) UsingTellor(_tellorAddress) {}

    uint256 public maticPrice;
    uint256 public ethPrice;
    // bytes maticPriceQueryData = abi.encode("SpotPrice", abi.encode("matic", "usd"));
    // bytes32 public maticPriceQueryId = keccak256(maticPriceQueryData);
    
    bytes32 public maticPriceQueryId = 0x40aa71e5205fdc7bdb7d65f7ae41daca3820c5d3a8f62357a99eda3aa27244a3;
    bytes32 public ethPriceQueryId = 0x0000000000000000000000000000000000000000000000000000000000000001;

    function getMaticPrice() public {
        bytes memory _maticPriceBytes;

        (, _maticPriceBytes, ) = getDataBefore(
            maticPriceQueryId,
            block.timestamp - 30 minutes
        );
        maticPrice = abi.decode(_maticPriceBytes, (uint256));
    }

    function getEthPrice() public {
        bytes memory _ethPriceBytes;

        (, _ethPriceBytes, ) = getDataBefore(
            ethPriceQueryId,
            block.timestamp - 30 minutes
        );
        ethPrice = abi.decode(_ethPriceBytes, (uint256));
    }
}
