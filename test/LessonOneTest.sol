// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonOne.sol";

contract LessonOneTest is TestHelper {
    LessonOne lessonOne = LessonOne(lesson1);

    function testSolve() external {
        vm.startPrank(usr);
        lessonOne.solveChallenge("@0xWagmi__");
        vm.stopPrank();
    }
}
