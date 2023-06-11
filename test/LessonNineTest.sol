// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonNine.sol";

import {AFoundryCourseChallenge} from "../src/FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonNineConsolelog is AFoundryCourseChallenge, Test {
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
        console.log("Hello :) : %s", correctAnswer);
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

contract LessonNineTest is TestHelper {
    LessonNine lessonNine = LessonNine(0xdF7cdFF0c5e85c974D6377244D9A0CEffA2b7A86);
    LessonNineConsolelog lessonNineWithlogs;

    function testSolve() external {
        lessonNineWithlogs = new LessonNineConsolelog(0x39338138414Df90EC67dC2EE046ab78BcD4F56D9);
        bytes memory code = address(lessonNineWithlogs).code;
        vm.etch(0xdF7cdFF0c5e85c974D6377244D9A0CEffA2b7A86, code);
        vm.startPrank(usr, usr);
        // uint256 correctAnswer =
        //     uint256(keccak256(abi.encodePacked(msg.sender, block.prevrandao, block.timestamp))) % 100000;
        uint256 correctAnswer = 85769;
        console.log("CorrectAnswer : %s", correctAnswer);
        lessonNine.solveChallenge(correctAnswer, "@0xWagmi__");
        vm.stopPrank();
    }
}
