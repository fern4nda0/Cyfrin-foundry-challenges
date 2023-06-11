// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonTen.sol";

interface Itoken {
    function mint() external;
}

contract LessonTenTest is TestHelper {
    LessonTen lessonTen = LessonTen(lesson10);

    function testSolve() external {
        vm.startPrank(usr);
        Itoken(0x0639FBe8a2cf42A0AE967dbf7ca9F4A8298C353B).mint();
        IERC20(0x0639FBe8a2cf42A0AE967dbf7ca9F4A8298C353B).approve(address(lesson10), type(uint256).max);
        lessonTen.solveChallenge("0xWagmi__");
        vm.stopPrank();
    }
}
