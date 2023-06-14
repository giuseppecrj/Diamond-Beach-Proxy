// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// interfaces

// libraries

// contracts

library TownStorage {
  bytes32 internal constant STORAGE_SLOT = keccak256("solidstate.proxy.storage");

  struct Layout {
    string[] channels;
  }

 function layout() internal pure returns (Layout storage ds) {
    bytes32 position = STORAGE_SLOT;

    // solhint-disable-next-line no-inline-assembly
    assembly {
      ds.slot := position
    }
  }
}
