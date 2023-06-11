// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonSix.sol";

contract LessonSixTest is TestHelper {
    LessonSix lessonSix = LessonSix(lesson6);

    function testSolve() external {
        vm.startPrank(usr);
        //cast send 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648 "solveChallenge((string,string)" "a","") --rpc-url URL --private-key=P
        lessonSix.solveChallenge("iceCream", "@0xWagmi__");
        vm.stopPrank();
    }
}
