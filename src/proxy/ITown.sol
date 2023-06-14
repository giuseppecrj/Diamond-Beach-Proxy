// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

// interfaces

// libraries

// contracts

interface ITown {
  function createChannel(string memory name) external;
  function removeChannel(string memory name) external;
}
