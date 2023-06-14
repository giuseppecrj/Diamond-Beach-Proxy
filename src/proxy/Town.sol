// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// interfaces
import {ITown} from "src/proxy/ITown.sol";

// libraries
import {SolidStateDiamond} from "solidstate-solidity/proxy/diamond/SolidStateDiamond.sol";
import {TownStorage} from "src/proxy/TownStorage.sol";

// contracts

contract Town is ITown, SolidStateDiamond {
  event ChannelCreated();
  event ChannelRemoved();

  function getChannels() external view returns (string[] memory) {
    TownStorage.Layout storage ds = TownStorage.layout();
    return ds.channels;
  }

  function createChannel(string memory name) external {
    TownStorage.Layout storage ds = TownStorage.layout();
    ds.channels.push(name);
    emit ChannelCreated();
  }

  function removeChannel(string memory name) external {
    TownStorage.Layout storage ds = TownStorage.layout();
    for (uint i = 0; i < ds.channels.length; i++) {
      if (keccak256(bytes(ds.channels[i])) == keccak256(bytes(name))) {
        ds.channels[i] = ds.channels[ds.channels.length - 1];
        ds.channels.pop();
        break;
      }
    }
    emit ChannelRemoved();
  }
}
