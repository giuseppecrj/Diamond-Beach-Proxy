// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// interfaces
import {IDiamondReadable} from "solidstate-solidity/proxy/diamond/readable/IDiamondReadable.sol";

// libraries
import {Proxy} from "solidstate-solidity/proxy/Proxy.sol";
import {TownStorage} from "src/proxy/TownStorage.sol";


contract TownProxy is Proxy {
  address internal immutable town;

  constructor(address town_) {
    town = town_;
  }

  function _getImplementation() internal view override returns (address) {
    return IDiamondReadable(town).facetAddress(msg.sig);
  }

  // solhint-disable-next-line no-empty-blocks
  receive() external payable {}
}
