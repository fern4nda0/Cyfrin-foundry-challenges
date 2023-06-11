// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonOne is AFoundryCourseChallenge {
    string private constant LESSON_IMAGE = "ipfs://QmYNk9TaRp9QDRjDZYxrwh5xQGMeC9zY23tB4fs5qby6KT";

    constructor(address fcn) AFoundryCourseChallenge(fcn) {}

    /*
     * CALL THIS FUNCTION!
     * 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(string memory yourTwitterHandle) external {
        _updateAndRewardSolver(yourTwitterHandle);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: Awesome! You got the basics down! You minted an NFT!";
    }

    function attribute() external pure override returns (string memory) {
        return "Getting learned!";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
