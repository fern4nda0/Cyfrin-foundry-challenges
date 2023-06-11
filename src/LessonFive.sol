// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonFive is AFoundryCourseChallenge {
    error LessonFive__WrongPassword();

    string private constant LESSON_IMAGE = "ipfs://QmarzFRs2c7prT7gWFF2BpcQ6tuZjy7TcV7AzsNTuxoVy8"; // TODO

    bytes32 public constant EXPECTED_BYTES = 0xb68fe43f0d1a0d7aef123722670be50268e15365401c442f8806ef83b612976b;

    constructor(address fcn) AFoundryCourseChallenge(fcn) {}

    /*
     * CALL THIS FUNCTION!
     * 
     * Use all the help you can on this one! Google, AI, friends, peeranha, ethereum stack exchange, etc. 
     * 
     * Hint: It's a very common...
     * 
     * @param password - A string that when you keccak256 it will return the `EXPECTED_BYTES`!
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(string memory password, string memory yourTwitterHandle) external {
        if (keccak256(abi.encodePacked(password)) == EXPECTED_BYTES) {
            _updateAndRewardSolver(yourTwitterHandle);
        } else {
            revert LessonFive__WrongPassword();
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: I'M PROOMMPPPTTIIINNNGGGGGG";
    }

    function attribute() external pure override returns (string memory) {
        return "One with the bots";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
