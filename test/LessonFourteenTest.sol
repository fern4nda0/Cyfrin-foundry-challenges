// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonFourteen.sol";

contract LessonFourteenTest is TestHelper {
    LessonFourteen lessonFourteen = LessonFourteen(lesson14);

    function testSolve() external {
        vm.startPrank(usr);
        lessonFourteen.solveChallenge("0xWagmi__", "Uniswap");
        vm.stopPrank();
    }
}
