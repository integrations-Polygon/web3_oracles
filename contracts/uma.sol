// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface Oracles {
    function requestPrice(
        bytes32 identifier,
        uint256 timestamp,
        bytes memory ancillaryData,
        address,
        uint256 reward
    ) external returns (uint256 totalBond);

    function settleAndGetPrice(
        bytes32 identifier,
        uint256 timestamp,
        bytes memory ancillaryData
    ) external returns (int256);

    function setCustomLiveness(
        bytes32 identifier,
        uint256 timestamp,
        bytes memory ancillaryData,
        uint256 customLiveness
    ) external;
}

//process:
 // request price
 // proposal price
 // settle and get price

contract UMA {
    Oracles oracle = Oracles(0xAB75727d4e89A7f7F04f57C00234a35950527115);
    int256 public price;

    uint256 public withdrawTimestamp;
    int256 public usdcAmount;
    address weth = 0xE03CFC9e275BD1298E77eA26d643feD7cd1AdBE2; //fee token
    uint256 liveness = 60; // in seconds, default : 7200

    bytes32 public id =
        0x5945535f4f525f4e4f5f51554552590000000000000000000000000000000000; //dai/usd

    //bytes32 public id = keccak256(abi.encode("BTCUSD"));

    function _requestPrice() public {
        withdrawTimestamp = block.timestamp;

        oracle.requestPrice(
        id, 
        withdrawTimestamp, 
        "", // extra arguments or data
        weth, 
        0);

        oracle.setCustomLiveness(id, withdrawTimestamp, "", liveness);
    }

    function withdrawMatic(int256 amount) public {
        price = oracle.settleAndGetPrice(id, withdrawTimestamp, "");
        usdcAmount = amount * price;

        //here withdraw logic for usdc
    }
}
