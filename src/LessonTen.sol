// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LessonTen is AFoundryCourseChallenge {
    error LessonTen__FailedToSolve();

    string private constant LESSON_IMAGE = "ipfs://QmXKkrYX72KznwQhnE7tmSsNtCerPZFwCkGctUWf5RshMe";
    uint256 private constant COST_TO_SOLVE = 1e18;

    IERC20 public immutable i_erc20;

    constructor(address fcn, address erc20) AFoundryCourseChallenge(fcn) {
        i_erc20 = IERC20(erc20);
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(string memory yourTwitterHandle) external {
        bool success = i_erc20.transferFrom(msg.sender, address(this), COST_TO_SOLVE);
        if (!success) {
            revert LessonTen__FailedToSolve();
        }
        _updateAndRewardSolver(yourTwitterHandle);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return "Cyfrin Foundry Full Course: I APPROVE of you getting this NFT!... Get it? Do you get my joke? ";
    }

    function attribute() external pure override returns (string memory) {
        return "Token understander";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
