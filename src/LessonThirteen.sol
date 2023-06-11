// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonThirteenHelper {
    int256 myValue = 100;

    function addTen(int256 number) public view returns (int256) {
        unchecked {
            return number + myValue + int256(10);
        }
    }
}

interface YourContract {
    function owner() external view returns (address);
    function getNumber() external view returns (int256);
}

contract LessonThirteen is AFoundryCourseChallenge {
    error LessonThirteen__NotSolved();

    string private constant LESSON_IMAGE = "ipfs://QmdHgyTYLg3hpjMdf6D9nE7Udwubxk2WvmJtv2KewCd6KM"; // TODO
    uint256 private constant TARGET_NUMBER = 1337;
    uint256 private LESSON_VERSION = 2;
    uint256 private COURSE_VERSION = 3;

    LessonThirteenHelper private immutable i_helperContract;

    constructor(address fcn) AFoundryCourseChallenge(fcn) {
        i_helperContract = new LessonThirteenHelper();
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param yourContract = the contract you're using to solve this
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(address yourContract, string memory yourTwitterHandle) external {
        YourContract yc = YourContract(yourContract);
        int256 number = yc.getNumber();
        address yourOwner = yc.owner();

        if (yourOwner != msg.sender) {
            revert LessonThirteen__NotSolved();
        }
        (bool success, bytes memory data) =
            address(i_helperContract).delegatecall(abi.encodeWithSignature("addTen(int256)", number));

        if (!success) {
            revert LessonThirteen__NotSolved();
        }
        uint256 result = abi.decode(data, (uint256));

        if (result != TARGET_NUMBER) {
            revert LessonThirteen__NotSolved();
        }
        _updateAndRewardSolver(yourTwitterHandle);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: I'd delegate call you to write me some contracts. ";
    }

    function attribute() external pure override returns (string memory) {
        return "Proxy Foxy";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
