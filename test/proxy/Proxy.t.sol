// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// utils
import {TestUtils} from "test/utils/TestUtils.sol";

//interfaces
import {IDiamondWritableInternal} from "solidstate-solidity/proxy/diamond/writable/IDiamondWritableInternal.sol";
import {ITown} from "src/proxy/ITown.sol";

//libraries

//contracts
import {Town} from "src/proxy/Town.sol";
import {TownProxy} from "src/proxy/TownProxy.sol";

contract ProxyTest is TestUtils {
  Town public town;

  function setUp() external {
    town = new Town();

    IDiamondWritableInternal.FacetCut[] memory facetCuts = new IDiamondWritableInternal.FacetCut[](1);
    facetCuts[0].target = address(town);
    facetCuts[0].action = IDiamondWritableInternal.FacetCutAction.ADD;
    facetCuts[0].selectors = new bytes4[](2);
    facetCuts[0].selectors[0] = town.createChannel.selector;
    facetCuts[0].selectors[1] = town.getChannels.selector;

    town.diamondCut(facetCuts, address(0), "");
  }

  function test_createTowns() external {
    address proxy1 = address(new TownProxy(address(town)));
    address proxy2 = address(new TownProxy(address(town)));

    ITown proxy1Town = ITown(proxy1);
    ITown proxy2Town = ITown(proxy2);

    proxy1Town.createChannel("test 1");
    proxy2Town.createChannel("test 2");
  }

  function test_updateTowns() external {
    address proxy1 = address(new TownProxy(address(town)));
     ITown proxy1Town = ITown(proxy1);

    // This will fail since implementation does not have removeChannel function yet
    vm.expectRevert();
    proxy1Town.removeChannel("test 1");

    // Add removeChannel function to implementation
    IDiamondWritableInternal.FacetCut[] memory facetCuts = new IDiamondWritableInternal.FacetCut[](1);
    facetCuts[0].target = address(town);
    facetCuts[0].action = IDiamondWritableInternal.FacetCutAction.ADD;
    facetCuts[0].selectors = new bytes4[](1);
    facetCuts[0].selectors[0] = town.removeChannel.selector;

    town.diamondCut(facetCuts, address(0), "");

    proxy1Town.removeChannel("test 1");
  }
}
