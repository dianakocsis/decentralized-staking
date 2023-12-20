// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ExampleExternalContract.sol";

contract Staker {
  uint256 public constant THRESHOLD = 1 ether;
  ExampleExternalContract public immutable exampleExternalContract;
  uint256 public immutable deadline;
  mapping(address => uint256) public balances;
  bool public openForWithdrawal;

  event Stake(address indexed sender, uint256 indexed amount);

  error DeadlineNotPassed(uint256 timestamp, uint256 deadline);
  error CannotStakeAfterDeadline(uint256 timestamp, uint256 deadline);
  error NotOpenForWithdrawal(bool openForWithdrawal);
  error TransferFailed();

  /// @notice Sets the `exampleExternalContract` and `deadline` variables
  /// @param exampleExternalContractAddress The address of the `ExampleExternalContract`
  constructor(address exampleExternalContractAddress) {
    exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
    deadline = block.timestamp + 72 hours;
  }

  /// @notice Modifier that checks if the deadline has passed
  modifier notCompleted() {
    if (timeLeft() > 0) {
      revert DeadlineNotPassed(block.timestamp, deadline);
    }
     _;
  }

  /// @notice Collects funds in a payable `stake()` function and tracks individual `balances` with a mapping
  function stake() public payable {
    if (timeLeft() == 0) {
      revert CannotStakeAfterDeadline(block.timestamp, deadline);
    }
    balances[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);
  }

  /// @notice After some `deadline` allows anyone to call an `execute()` function and
  ///         if the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete`
  function execute() external notCompleted {
    if (address(this).balance < THRESHOLD) {
      openForWithdrawal = true;
    } else {
      exampleExternalContract.complete{value: address(this).balance}();
    }
  }

  /// @notice If the deadline has passed and the threshold is not met, it should allow everyone to
  ///         call `withdraw()`
  function withdraw() external notCompleted {
    if (openForWithdrawal) {
      uint256 amount = balances[msg.sender];
      balances[msg.sender] = 0;
      (bool success, ) = msg.sender.call{value: amount}("");
      if (!success) {
        revert TransferFailed();
      }
    } else {
      revert NotOpenForWithdrawal(openForWithdrawal);
    }
  }

  /// @notice Returns the time left before the deadline
  function timeLeft() public view returns (uint256) {
    if (block.timestamp >= deadline) {
      return 0;
    } else {
      return deadline - block.timestamp;
    }
  }

  /// @notice Allows the contract to receive funds and calls `stake()`
  receive() external payable {
    stake();
  }
}