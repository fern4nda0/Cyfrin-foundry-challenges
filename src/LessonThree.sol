// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonThreeHelper {
    bool[5] internal s_booleanArray;

    function getArrayElement(uint256 index) external view returns (bool) {
        return s_booleanArray[index];
    }
}

contract LessonThree is AFoundryCourseChallenge, LessonThreeHelper {
    error LessonThree__WrongLocation();

    string private constant LESSON_IMAGE = "ipfs://QmfWyPRrx1sx7sfgrwr4pNMWtqVLXMwCP4fej39m2fPfYe";

    constructor(address fcn) AFoundryCourseChallenge(fcn) {
        s_booleanArray = [false, false, false, true, false];
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param location - The location of the true boolean. 
     * @param newLocation - Pick the spot of the boolean for the next person!
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(uint256 location, uint256 newLocation, string memory yourTwitterHandle) external {
        if (s_booleanArray[location] != true) {
            revert LessonThree__WrongLocation();
        }
        s_booleanArray[location] = false;
        s_booleanArray[newLocation] = true;
        _updateAndRewardSolver(yourTwitterHandle);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: You've inherited skillz from solidity!";
    }

    function attribute() external pure override returns (string memory) {
        return "Inheritance and factory pattern knowledgable";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
