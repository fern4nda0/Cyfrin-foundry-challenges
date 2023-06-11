// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonTwo is AFoundryCourseChallenge {
    error LessonTwo__WrongNumberGuessed();

    string private constant LESSON_IMAGE = "ipfs://QmZdPncUtsq71DxVtebbGdCUS28SvrCWoeVigCAdo1CZ5b";
    uint256 private someNumber;

    constructor(address fcn) AFoundryCourseChallenge(fcn) {
        someNumber = 123;
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param number - The number you think solves the challenge. 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(uint256 number, string memory yourTwitterHandle) external {
        if (number == someNumber) {
            _updateAndRewardSolver(yourTwitterHandle);
        } else {
            revert LessonTwo__WrongNumberGuessed();
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: You simply stored simple storage, which is simply awesome!";
    }

    function attribute() external pure override returns (string memory) {
        return "Leveling up solidity...";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
