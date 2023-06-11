// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract TestHelper is Test {
    address usr;
    address lesson1 = 0x2e99A4CA9c85383ccB54769adB3837437e296479;
    address lesson2 = 0x76D2403b80591d5F6AF2b468BC14205fa5452AC0;
    address lesson3 = 0x34d130B174F4a30A846FED7C02FCF53A19a4c2B6;
    address lesson4 = 0xA2626bE06C11211A44fb6cA324A67EBDBCd30B70;
    address lesson5 = 0xf988Ebf9D801F4D3595592490D7fF029E438deCa;
    address lesson6 = 0xdeB8d8eFeF7049E280Af1d5FE3a380F3BE93B648;
    address lesson7 = 0xcf4fbA490197452Bd414E16D563623253eFb57D3;
    address lesson8 = 0x33ee14Fb8816c92fe401165330bbE29706942183;
    address lesson9 = 0xdF7cdFF0c5e85c974D6377244D9A0CEffA2b7A86;
    address lesson10 = 0xaB67557218F60C06acA750B9F8A20018e5604ebf;
    address lesson11 = 0x444aE92325dCE5D14d40c30d2657547513674dD6;
    address lesson12 = 0x3DbBF2F9AcFB9Aac8E0b31563dd75a2D69148D64;
    address lesson13 = 0x3aD9F29AB266E4828450B33df7a9B9D7355Cd821;
    address lesson14 = 0xc584bD01fD60F671409661a6802170BbEFba5c47;
    address lesson15 = 0xa0c7ADA2c7c29729d12e2649BC6a0a293Ac46725;

    function setUp() public {
        vm.createSelectFork("arb", 99972157);
        usr = makeAddr("Usr");
        vm.deal(usr, 1e18);
    }
}
