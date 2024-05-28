// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";

contract PixotchiExtensionPermission  {
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    modifier onlyAdminRole() {
        require(Permissions(address(this)).hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "not default admin role");
        _;
    }

}
