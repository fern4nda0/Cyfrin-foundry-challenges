// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonThirteen.sol";


contract Solve13 {
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function getNumber() external view returns (int256) {
        int256 a = -225441599405899442401691852615198556509900170540;
        return a;
    }
}

contract LessonThirteenTest is TestHelper {
    LessonThirteen lessonThirteen = LessonThirteen(lesson13);
    Solve13 ex;

    function testSolve() external {
        vm.startPrank(usr);
        ex = new Solve13();
        lessonThirteen.solveChallenge(address(ex), "0xWagmi__");
        vm.stopPrank();
    }
}
