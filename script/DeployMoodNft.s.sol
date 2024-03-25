// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft private moodNft;

    function run() public returns (MoodNft) {
        string memory happySvg = vm.readFile("./img/happy.svg");
        string memory sadSvg = vm.readFile("./img/sad.svg");

        vm.startBroadcast();
        moodNft = new MoodNft(
            _convertSvgToBase64(happySvg),
            _convertSvgToBase64(sadSvg)
        );
        vm.stopBroadcast();

        return moodNft;
    }

    function _baseURI() private pure returns (string memory) {
        return "data:image/svg+xml;base64,";
    }

    function _convertSvgToBase64(
        string memory svg
    ) internal pure returns (string memory) {
        string memory base64Svg = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(_baseURI(), base64Svg));
    }
}
