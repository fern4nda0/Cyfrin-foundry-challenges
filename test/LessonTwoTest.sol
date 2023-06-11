// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonTwo.sol";

contract LessonTwoTest is TestHelper {
    LessonTwo lessonTwo = LessonTwo(lesson2);

    function testSolve() external {
        vm.startPrank(usr);
        lessonTwo.solveChallenge(0x7B, "@0xWagmi__");
        vm.stopPrank();
    }
}
