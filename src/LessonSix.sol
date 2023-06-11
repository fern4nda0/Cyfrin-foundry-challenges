// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";

contract LessonSix is AFoundryCourseChallenge {
    string private constant LESSON_IMAGE = "ipfs://QmZ8oE5hYAsoBL2f4Lih7ZPsBEYEsKo6BdY8ZPsjNsXJ7M"; // TODO
    mapping(address user => string iceCreamOrFood) private s_addressToIceCreamOrFood;

    constructor(address fcn) AFoundryCourseChallenge(fcn) {}

    /*
     * CALL THIS FUNCTION!
     * 
     * I challenge you to try to call this with the cast command! 
     * 
     * @param yourFavoriteIceCream - Your favorite ice cream 🍦 (or food if ice cream isn't your thing). 
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(string memory yourFavoriteIceCream, string memory yourTwitterHandle) external {
        _updateAndRewardSolver(yourTwitterHandle);
        s_addressToIceCreamOrFood[msg.sender] = yourFavoriteIceCream;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return unicode"Cyfrin Foundry Full Course: ⚒️ 🌋 🦾 We are in foundry! And excited to eat ";
    }

    function extraDescription(address user) external view override returns (string memory) {
        return s_addressToIceCreamOrFood[user];
    }

    function attribute() external pure override returns (string memory) {
        return "Yoked, stoked, and ready to code alongside ripped jesus";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
