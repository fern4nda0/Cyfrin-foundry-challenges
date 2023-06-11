// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonFour.sol";

contract LessonFourTest is TestHelper {
    LessonFour lessonFour = LessonFour(lesson4);

    function testSolve() external {
        (, int256 price,,,) = AggregatorV3Interface(0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612).latestRoundData();
        console.log("What is price : %s", uint256(price));
        /*
        [PASS] testSolve() (gas: 27549)
        Logs:
    What is price : 175841260000
        */

        vm.startPrank(usr);

        lessonFour.solveChallenge(uint256(price) * 10e10, "@0xWagmi__");
        vm.stopPrank();
    }
}
