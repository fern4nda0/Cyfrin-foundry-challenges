// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonThree.sol";

contract LessonThreeTest is TestHelper {
    LessonThree lessonThree = LessonThree(lesson3);

    function testSolve() external {
        uint256 solve;
        for (uint256 i = 0; i < 5; i++) {
            bool x = lessonThree.getArrayElement(i);
            if (x == true) {
                console.log("Correct number %s", i);
                solve = i;
            }
        }
        vm.startPrank(usr);

        lessonThree.solveChallenge(solve, 0, "@0xWagmi__");
        vm.stopPrank();
    }
}
