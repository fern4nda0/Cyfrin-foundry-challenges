// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonNine.sol";

contract LessonNineTest is TestHelper {
    LessonNine lessonNine = LessonNine(0xdF7cdFF0c5e85c974D6377244D9A0CEffA2b7A86);

    function testSolve() external {
        vm.startPrank(usr, usr);
        uint256 correctAnswer =
            uint256(keccak256(abi.encodePacked(msg.sender, block.prevrandao, block.timestamp))) % 100000;
        console.log("CorrectAnswer : %s", correctAnswer);
        lessonNine.solveChallenge(correctAnswer, "@0xWagmi__");
        vm.stopPrank();
    }
}
