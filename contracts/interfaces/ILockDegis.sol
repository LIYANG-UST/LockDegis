// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILockDegis {
  function getInvestorNameByIndex(uint256 _index)
    external
    view
    returns (string memory);

  function getInvestorName(address _investor)
    external
    view
    returns (string memory);

  // Init all the investor information
  function setInvestorInfo(
    address _investor,
    string memory _name,
    uint256 _totalAmount,
    uint256 _unlockTime,
    uint256 _unlockInterval,
    uint256 _releaseAmountEachTime
  ) external;

  // Manually release
  function release(address _investor) external;

  function checkUnlockTime(uint256 _index, address _investor)
    external
    view
    returns (bool);
}
