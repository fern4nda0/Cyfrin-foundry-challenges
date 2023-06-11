// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonEleven is AFoundryCourseChallenge {
    error LessonEleven__WrongSelector();
    error LessonEleven__WrongData();

    string private constant LESSON_IMAGE = "ipfs://QmZhuLYuSdxuN35ANgYNLGhX3s4eSbdYFqheyd1PqCDco2"; // TODO

    address private immutable i_helperContract;

    constructor(address fcn, address helperContract) AFoundryCourseChallenge(fcn) {
        i_helperContract = helperContract;
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param the function selector of the first one you need to call
     * @param the abi encoded data... hint! Use chisel to figure out what to use here...
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(bytes4 selectorOne, bytes memory inputData, string memory yourTwitterHandle) external {
        (bool successOne, bytes memory responseDataOne) = i_helperContract.call(abi.encodeWithSelector(selectorOne));
        if (!successOne || uint256(bytes32((responseDataOne))) != 1) {
            revert LessonEleven__WrongSelector();
        }

        (bool successTwo, bytes memory responseDataTwo) = i_helperContract.call(inputData);
        if (!successTwo || uint256(bytes32((responseDataTwo))) != 1) {
            revert LessonEleven__WrongData();
        }
        _updateAndRewardSolver(yourTwitterHandle);
    }

    function getHelperContract() external view returns (address) {
        return i_helperContract;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return unicode"Cyfrin Foundry Full Course: But here's my function signature, so call me, maybe 📞";
    }

    function attribute() external pure override returns (string memory) {
        return "Knowledge of NFTs, Encoding, IPFS";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
