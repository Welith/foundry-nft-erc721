// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft private deployBasicNft;
    BasicNft private basicNft;
    string private constant NFT_URI =
        "https://ipfs.io/ipfs/Qmb68TAjxyZFMFb2TUSqGzhJR8gsyR5C4pyA7TG8eULakh?filename=st-bernard.json";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNftInitializesWithProperAttributes() public view {
        assertEq(basicNft.name(), "BasicNFT");
        assertEq(basicNft.symbol(), "BNFT");
    }

    function testCanMintAndHaveBalance() public {
        address user = makeAddr("test_user");
        vm.prank(user);
        basicNft.mintNft(NFT_URI);

        assertEq(basicNft.balanceOf(user), 1);
    }
}
