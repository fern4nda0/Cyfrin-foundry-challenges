// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonEleven.sol";

contract LessonElevenTest is TestHelper {
    LessonEleven lessonEleven = LessonEleven(lesson11);

    function testSolve() external {
        vm.startPrank(usr);
        bytes memory data = abi.encodeWithSignature(
            "returnTrueWithGoodValues(uint256,address)", uint256(9), 0x4221EC0A43138CF0135b2Bd91Dd3b176E1E22908
        );
        lessonEleven.solveChallenge(0xf613a687, data, "0xWagmi__");
        vm.stopPrank();
    }
}
