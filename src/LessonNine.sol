// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonNine is AFoundryCourseChallenge {
    error LessonNine__WrongValue();

    string private constant LESSON_IMAGE = "ipfs://QmdqVCFTAirHW7tD1YpVKnqQFDhRd8UopQdLTrmWBjNfr3";

    constructor(address fcn) AFoundryCourseChallenge(fcn) {}

    /*
     * CALL THIS FUNCTION!
     * 
     * @param randomGuess - Your random guess... or not so random
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(uint256 randomGuess, string memory yourTwitterHandle) external {
        // Do we have a 1 in 100,000 chance of getting it right?
        // ...or can we cheat?
        uint256 correctAnswer =
            uint256(keccak256(abi.encodePacked(msg.sender, block.prevrandao, block.timestamp))) % 100000;

        if (randomGuess == correctAnswer) {
            _updateAndRewardSolver(yourTwitterHandle);
        } else {
            revert LessonNine__WrongValue();
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return unicode"Cyfrin Foundry Full Course: 🎲 I AM THE RANDOMNESS MASTER!!! I HAVE FOUND MY FIRST EXPLOIT!!";
    }

    function attribute() external pure override returns (string memory) {
        return "RNG, Automation, and Oracleness";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
