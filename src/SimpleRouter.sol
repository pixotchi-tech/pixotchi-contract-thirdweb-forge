
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import "@thirdweb-dev/dynamic-contracts/src/presets/BaseRouter.sol";
import {BaseRouter, IRouter, IRouterState} from "../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import  "../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../lib/contracts/contracts/extension/upgradeable/init/ReentrancyGuardInit.sol";


/// Example usage of `BaseRouter`, for demonstration only

contract SimpleRouter is
    Initializable,
    BaseRouter,
    PermissionsEnumerable,
    ReentrancyGuardInit
{
    /// @dev Only EXTENSION_ROLE holders can perform upgrades.
    bytes32 private constant EXTENSION_ROLE = keccak256("EXTENSION_ROLE");

    address public tokenAddress;

    /// @dev We accept constructor params as a struct to avoid `Stack too deep` errors.
    struct SimpleRouterConstructorParams {
        Extension[] extensions;
        address tokenAddress;
    }

    constructor(
        SimpleRouterConstructorParams memory _simpleRouterV3Params
    ) BaseRouter(_simpleRouterV3Params.extensions)  {
        //_disableInitializers();

        // Initialize BaseRouter
        __BaseRouter_init();
        tokenAddress = _simpleRouterV3Params.tokenAddress;

        // Initialize inherited contracts, most base-like -> most derived.
        __ReentrancyGuard_init();
        //__ERC2771Context_init(_trustedForwarders);

        // Initialize this contract's state.
        //_setupContractURI(_contractURI);
        address _defaultAdmin = msg.sender;

        _setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);
        _setupRole(EXTENSION_ROLE, _defaultAdmin);
        _setupRole(keccak256("LISTER_ROLE"), address(0));
        _setupRole(keccak256("ASSET_ROLE"), address(0));

        _setupRole(EXTENSION_ROLE, _defaultAdmin);
        _setRoleAdmin(EXTENSION_ROLE, EXTENSION_ROLE);

    }

    /*///////////////////////////////////////////////////////////////
                        Overridable Permissions
    //////////////////////////////////////////////////////////////*/

    /// @dev Checks whether an account has a particular role.
    function _hasRole(bytes32 _role, address _account) internal view returns (bool) {
        PermissionsStorage.Data storage data = PermissionsStorage.data();
        return data._hasRole[_role][_account];
    }

    /// @dev Returns whether all relevant permission and other checks are met before any upgrade.
    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
        return _hasRole(EXTENSION_ROLE, msg.sender);
    }

    receive() external payable {
    }
}
