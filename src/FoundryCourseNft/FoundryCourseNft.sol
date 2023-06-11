// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {IFoundryCourseNft} from "./IFoundryCourseNft.sol";
import {IFoundryCourseChallenge} from "./IFoundryCourseChallenge.sol";

/*
 * @title FoundryCourseNft
 * @author cyfrin.io
 * 
 * @notice check out https://web3education.dev for more badass web3 content!
 *
 * @notice This contract is used to mint NFTs for the Foundry 2023 ultimate course
 * each NFT is associated with a unique contract where devs can solve the challenge
 * associated with that address, and earn the NFT as a reward.
 *
 * Each challenge needs to be added to this contract, and only then can an NFT be minted.
 */
contract FoundryCourseNft is ERC721, Ownable, IFoundryCourseNft {
    /////////////
    // Errors  //
    /////////////
    error FoundryCourseNft__NotChallengeContract();
    error FoundryCourseNft__NFTNotMinted();
    error FoundryCourseNft__YouAlreadySolvedThis();

    //////////////////////
    // State Variables  //
    //////////////////////

    string private s_baseTokenImageUri = "ipfs://QmZg79jdDNBTi3fxwnjXTvbM9Gtd1C84Axo55Ht2kYCeDH";

    uint256 private s_tokenCounter;
    mapping(uint256 => address) private s_tokenIdToChallengeContract;
    mapping(address user => mapping(address challenge => bool hasSolved)) private s_userToChallengeToHasSolved;
    address[] private s_challengeContracts;

    string private constant DEFAULT_ATTRIBUTE = "Getting learned!";

    /////////////
    // Events  //
    /////////////
    event ChallengeAdded(address challengeContract);
    event ChallengeReplaced(address oldChallenge, address newChallenge);
    event BaseTokenImageUriChanged(string newUri);
    event ChallengeSolved(address solver, address challenge, string twitterHandle);

    ////////////////
    // Modifiers  //
    ////////////////
    modifier onlyChallengeContract(address contractAddress) {
        for (uint256 i; i < s_challengeContracts.length; i++) {
            if (s_challengeContracts[i] == contractAddress) {
                _;
                return;
            }
        }
        revert FoundryCourseNft__NotChallengeContract();
    }

    //////////////////////////////
    // Functions - Constructor  //
    //////////////////////////////
    constructor() ERC721("Foundry Course NFT", "FCN") {}

    ////////////////////////////
    // Functions - External  //
    ///////////////////////////
    function addChallenge(address challengeContract) external onlyOwner returns (address) {
        s_challengeContracts.push(challengeContract);
        emit ChallengeAdded(challengeContract);
        return challengeContract;
    }

    function replaceChallenge(uint256 challengeIndex, address newChallenge) external onlyOwner {
        address oldChallenge = s_challengeContracts[challengeIndex];
        s_challengeContracts[challengeIndex] = newChallenge;
        emit ChallengeReplaced(oldChallenge, newChallenge);
    }

    function changeBaseUri(string memory newUri) external onlyOwner {
        s_baseTokenImageUri = newUri;
        emit BaseTokenImageUriChanged(newUri);
    }

    /*
     * @dev This function is used to mint an NFT for a challenge contract.
     * Once a challenge contract is solved, the challenge contract should call
     * this function to mint an NFT for the user.
     *
     * @dev _safeMint has a check to make sure the tokenId hasn't already been
     * minted, so we don't need to check that here.
     */
    function mintNft(address receiver, string memory twitterHandle)
        external
        onlyChallengeContract(msg.sender)
        returns (uint256)
    {
        if (s_userToChallengeToHasSolved[receiver][msg.sender] == true) {
            revert FoundryCourseNft__YouAlreadySolvedThis();
        }
        uint256 tokenId = s_tokenCounter;
        s_tokenIdToChallengeContract[tokenId] = msg.sender;
        s_userToChallengeToHasSolved[receiver][msg.sender] = true;
        _safeMint(receiver, tokenId);
        emit ChallengeSolved(receiver, msg.sender, twitterHandle);
        s_tokenCounter = s_tokenCounter + 1;
        return tokenId;
    }

    //////////////////////////
    // Functions - Public  //
    /////////////////////////

    ///////////////////////////
    // Functions - Internal  //
    ///////////////////////////

    ///////////////////////////
    // Functions - Private  //
    //////////////////////////

    //////////////////////////////
    // Functions - View & Pure  //
    //////////////////////////////

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (!_exists(tokenId)) {
            revert FoundryCourseNft__NFTNotMinted();
        }
        IFoundryCourseChallenge courseChallenge = IFoundryCourseChallenge(s_tokenIdToChallengeContract[tokenId]);
        // check to see if the challenge has a special image using a string comparison
        string memory imageUriOfTokenId = keccak256(bytes(courseChallenge.specialImage())) != keccak256(bytes(""))
            ? courseChallenge.specialImage()
            : s_baseTokenImageUri;

        string memory attribute = keccak256(bytes(courseChallenge.attribute())) != keccak256(bytes(""))
            ? courseChallenge.attribute()
            : DEFAULT_ATTRIBUTE;

        address owner = ownerOf(tokenId);

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description": "',
                            courseChallenge.description(),
                            courseChallenge.extraDescription(owner),
                            '", ',
                            '"attributes": [{"trait_type": "',
                            attribute,
                            '", "value": 100}], "image":"',
                            imageUriOfTokenId,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    /*
     * @dev Returns true if the contract address is a challenge contract.
     * It will return false for the RemoveChallenge contract.
     */
    function isChallengeContract(address contractAddress) external view returns (bool) {
        for (uint256 i; i < s_challengeContracts.length; i++) {
            if (s_challengeContracts[i] == contractAddress) {
                return true;
            }
        }
        return false;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function getChallengeContract(uint256 index) external view returns (address) {
        return s_challengeContracts[index];
    }

    function getChallengeContractFromTokenId(uint256 tokenId) external view returns (address) {
        return s_tokenIdToChallengeContract[tokenId];
    }

    function getChallengeContractFullDescription(uint256 tokenId) external view returns (string memory) {
        IFoundryCourseChallenge courseChallenge = IFoundryCourseChallenge(s_tokenIdToChallengeContract[tokenId]);
        address owner = ownerOf(tokenId);
        string memory description = courseChallenge.description();
        string memory extraDescription = courseChallenge.extraDescription(owner);
        return string(abi.encodePacked(description, extraDescription));
    }
}
