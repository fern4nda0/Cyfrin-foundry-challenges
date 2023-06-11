// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AFoundryCourseChallenge} from "./FoundryCourseNft/AFoundryCourseChallenge.sol";
import {AggregatorV3Interface} from "./FoundryCourseNft/AggregatorV3Interface.sol";

contract LessonFour is AFoundryCourseChallenge {
    error LessonFour__WrongPrice();

    string private constant LESSON_IMAGE = "ipfs://QmSCoS3N8qFy2D3Tn4vTPKTFAC1TAqSZgg9R4uCb7fZL7Q";
    address private immutable i_priceFeed;

    constructor(address fcn, address priceFeed) AFoundryCourseChallenge(fcn) {
        i_priceFeed = priceFeed;
    }

    function getPrice() private view returns (uint256) {
        (, int256 price,,,) = AggregatorV3Interface(i_priceFeed).latestRoundData();
        return uint256(price);
    }

    function getDecimals() private view returns (uint8) {
        return AggregatorV3Interface(i_priceFeed).decimals();
    }

    function getPriceFeed() external view returns (address) {
        return i_priceFeed;
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param priceGuess - Your guess for the price based on the feed. It can be withing a few tokens.
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(uint256 priceGuess, string memory yourTwitterHandle) external {
        uint256 actualPrice = getPrice();
        if (getDecimals() == 8) {
            actualPrice = actualPrice * 10e10;
        }
        if (actualPrice + 3e18 > priceGuess && actualPrice - 3e18 < priceGuess) {
            _updateAndRewardSolver(yourTwitterHandle);
        } else {
            revert LessonFour__WrongPrice();
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// The following are functions needed for the NFT, feel free to ignore. ///////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function description() external pure override returns (string memory) {
        return
        "Cyfrin Foundry Full Course: Oracles, payments, and some best practices? You've completed the Remix portion of the course!";
    }

    function attribute() external pure override returns (string memory) {
        return "Remix Pro";
    }

    function specialImage() external pure override returns (string memory) {
        return LESSON_IMAGE;
    }
}
