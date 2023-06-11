// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonSeven.sol";

contract LessonSevenTest is TestHelper {
    LessonSeven lessonSeven = LessonSeven(lesson7);

    function testSolve() external {
        vm.startPrank(usr);
        uint256 slot = 777;
        bytes32 data = vm.load(lesson7, bytes32(slot));
        console.logBytes32(data);
        console.log(uint256(data));
        lessonSeven.solveChallenge(uint256(data), "@0xWagmi__");
        vm.stopPrank();
    }
}
