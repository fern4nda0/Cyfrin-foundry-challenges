// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonFourteen is AFoundryCourseChallenge {
    string private constant LESSON_IMAGE = "ipfs://QmV7SvNVfGAmJa4ev33N12W7TmzMra2hshfnLZQ3TESr2y";

    mapping(address => string) private s_userToDao;

    constructor(address fcn) AFoundryCourseChallenge(fcn) {}

    /*
     * CALL THIS FUNCTION!
     * 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     * @param aDaoYouWantToLookInto - The address of the DAO you want to look into, and you'll do 
     * some research on your own on! Like Aave, Uniswap, etc. 
     */
    function solveChallenge(string memory yourTwitterHandle, string memory aDaoYouWantToLookInto) external {
        s_userToDao[msg.sender] = aDaoYouWantToLookInto;
        _updateAndRewardSolver(yourTwitterHandle);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: This user pledges to look into : ";
    }

    function extraDescription(address user) external view override returns (string memory) {
        return s_userToDao[user];
    }

    function attribute() external pure override returns (string memory) {
        return "Decentralized & transparent organizations rule. ";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
