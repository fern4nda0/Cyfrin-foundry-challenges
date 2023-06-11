// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";
import "../src/LessonTwelve.sol";

interface Ij {
    function hellFunc(uint128 numberr) external view returns (uint256);
}

contract Solver {
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function getNumberr() external returns (uint128) {
        return 99;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}

contract LessonTwelveTest is TestHelper {
    LessonTwelve lessonTwelve = LessonTwelve(lesson12);
    Solver solve;

    // function testFuzz_helFunc(uint128 number) public {
    //     vm.startPrank(lesson12);
    //     uint256 num = Ij(0x322683Ea3CD423719A449c6C8f6298b0262F6e9c).hellFunc(number);
    //     console.log(num);
    //     vm.stopPrank();
    // }

    function testSolve() external {
        vm.startPrank(usr);
        solve = new Solver();
        lessonTwelve.solveChallenge(address(solve), "0xWagmi__");
        vm.stopPrank();
    }
}
