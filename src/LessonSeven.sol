// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonSeven is AFoundryCourseChallenge {
    error LessonSeven__WrongValue();

    string private constant LESSON_IMAGE = "ipfs://QmUCK8YsB7Ln5u4Sn6WdsgtD87eEv5fCy1VaG8waMxXq6Q";
    uint256 private constant STARTING_NUMBER = 123;
    uint256 private constant STORAGE_LOCATION = 777;

    constructor(address fcn) AFoundryCourseChallenge(fcn) {
        assembly {
            sstore(STORAGE_LOCATION, STARTING_NUMBER)
        }
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param valueAtStorageLocationSevenSevenSeven - The value at storage location 777.
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(uint256 valueAtStorageLocationSevenSevenSeven, string memory yourTwitterHandle) external {
        uint256 value;
        assembly {
            value := sload(STORAGE_LOCATION)
        }
        if (value != valueAtStorageLocationSevenSevenSeven) {
            revert LessonSeven__WrongValue();
        }
        uint256 newValue = uint256(keccak256(abi.encodePacked(msg.sender, block.prevrandao, block.timestamp))) % 1000000;
        assembly {
            sstore(STORAGE_LOCATION, newValue)
        }
        _updateAndRewardSolver(yourTwitterHandle);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return
        unicode"Cyfrin Foundry Full Course: ⛽️⛽️⛽️⛽️⛽️⛽️ 📦 With great storage knowledge comes great gas savings. Save 15% or more on your gas by switching to memory variables.";
    }

    function attribute() external pure override returns (string memory) {
        return "Cast and storage wizard";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
