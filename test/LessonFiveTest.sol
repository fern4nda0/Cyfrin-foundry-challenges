// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonFive.sol";

contract LessonFiveTest is TestHelper {
    LessonFive lessonFive = LessonFive(lesson5);

    function testSolve() external {
        vm.startPrank(usr);
        //password
        lessonFive.solveChallenge("password", "@0xWagmi__");
        vm.stopPrank();
    }
}
