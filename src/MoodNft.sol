// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    error MoodNft__CannotFlipMood(address sender, uint256 tokenId);

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happySvgImageUri,
        string memory sadSvgImageUri
    ) ERC721("MoodNFT", "MNFT") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodNft__CannotFlipMood(msg.sender, tokenId);
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory moodSvgImageUri;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            moodSvgImageUri = s_happySvgImageUri;
        } else {
            moodSvgImageUri = s_sadSvgImageUri;
        }

        string memory tokenMetadata = Base64.encode(
            abi.encodePacked(
                '{"name": "MoodNFT #',
                name(),
                '", "description": "An NFT that represents the owners mood", "image": "',
                moodSvgImageUri,
                '"}'
            )
        );

        return string(abi.encodePacked(_baseURI(), tokenMetadata));
    }
}
