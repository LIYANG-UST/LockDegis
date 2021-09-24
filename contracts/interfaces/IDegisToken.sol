// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @dev Based on the interface of the ERC20 standard.
 * Just add some boring functions.
 */
interface IDegisToken is IERC20 {
    /**
     * @dev Pass the minter role.
     */
    function passMinterRole(address) external returns (bool);

    /**
     * @dev Mint some tokens.
     */
    function mint(address, uint256) external;

    // Indicate that the minter Changed !!!
    event MinterChanged(address indexed from, address indexed to);
}
