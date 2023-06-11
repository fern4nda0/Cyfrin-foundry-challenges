// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonFifteen.sol";

contract Solving {
    address immutable owner;
    uint256 public s_variable = 0;
    uint256 public s_otherVar = 0;

    constructor() {
        owner = msg.sender;
    }

    function getOwner() external returns (address) {
        return owner;
    }

    function doSomething() external {
        s_variable = 123;
        s_otherVar = 2;
    }

    function end() external returns (bool) {
        return true;
    }
}

contract LessonFifteenTest is TestHelper {
    LessonFifteen lessonFifteen = LessonFifteen(lesson15);
    Solving solving;

    function testSolve() external {
        vm.startPrank(usr);
        solving = new Solving();
        // uint256 v = VulnerableContract(0x63293f1b49e454485Ed83B191633bd99d686d60E).s_otherVar();
        // console.log(v);
        lessonFifteen.solveChallenge(address(solving), 0xefbe1c1c, "0xWagmi__");
        vm.stopPrank();
    }
}
