// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

/// @title ExampleExternalContract
contract ExampleExternalContract {

  bool public completed;

  /// @notice Sets the `completed` variable to true
  function complete() public payable {
    completed = true;
  }
}
