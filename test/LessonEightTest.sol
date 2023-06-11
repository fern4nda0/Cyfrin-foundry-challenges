// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./TestHelper.sol";

contract LessonEightTest is TestHelper {
    function testSolve() external {
        vm.startPrank(usr);
        uint256 num = 123456789;
        bytes memory data = abi.encodeWithSignature("solveChallenge(uint256,string)", num, "0xWagmi__");
        (bool s,) = 0x33ee14Fb8816c92fe401165330bbE29706942183.call(data);
        require(s, "Error");
        vm.stopPrank();
    }
}
