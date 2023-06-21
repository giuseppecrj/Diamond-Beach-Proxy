// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// interfaces

// libraries

// contracts

interface IMockFacet {
  function mockFunction() external pure returns (bool);
}

contract MockFacet is IMockFacet {
  function mockFunction() external pure returns (bool) {
    return true;
  }
}
