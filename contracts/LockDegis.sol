// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract LockDegis {
  using SafeERC20 for IERC20;

  address public owner;
  IERC20 DegisToken;

  address[] public investorList;

  struct InvestorInfo {
    string name;
    uint256 totalAmount;
    uint256 lockedAmount;
    uint256 unlockTime;
    uint256 releaseAmountEachTime;
    uint256 releaseTimes;
  }

  mapping(address => InvestorInfo) investorInfo;

  modifier onlyOwner() {
    require(msg.sender == owner, "only the owner can call this function");
    _;
  }

  constructor(IERC20 _degisAddress) {
    DegisToken = _degisAddress;
    owner = msg.sender;
  }

  function getInvestorNameByIndex(uint256 _index)
    external
    view
    returns (string memory)
  {
    address investor = investorList[_index];
    return investorInfo[investor].name;
  }

  function getInvestorName(address _investor)
    external
    view
    returns (string memory)
  {
    return investorInfo[_investor].name;
  }

  function setInvestorInfo(
    address _investor,
    string memory _name,
    uint256 _totalAmount,
    uint256 _unlockTime,
    uint256 _releaseAmountEachTime
  ) external onlyOwner {
    investorInfo[_investor] = InvestorInfo(
      _name,
      _totalAmount,
      _totalAmount,
      _unlockTime,
      _releaseAmountEachTime,
      0
    );
    investorList.push(_investor);
  }

  function release(address _investor) public onlyOwner {
    uint256 unlock = investorInfo[_investor].unlockTime;
    require(block.timestamp > unlock, "have not reached the unlock time");

    uint256 amount = investorInfo[_investor].releaseAmountEachTime;

    DegisToken.safeTransfer(_investor, amount);
    investorInfo[_investor].releaseTimes += 1;
  }

  function checkUnlockTime(uint256 _index, address _investor)
    public
    view
    returns (bool)
  {
    require(investorList[_index] == _investor, "wrong investor address");

    uint256 unlock = investorInfo[_investor].unlockTime;
    if (block.timestamp > unlock) {
      return true;
    } else {
      return false;
    }
  }
}
