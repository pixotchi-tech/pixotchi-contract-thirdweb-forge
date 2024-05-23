// SPDX-License-Identifier: MIT
// @author: thirdweb (https://github.com/thirdweb-dev/dynamic-contracts)

pragma solidity ^0.8.0;

import "../lib/dynamic-contracts/src/presets/BaseRouter.sol";
//import "../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
//import "../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
//import "../lib/contracts/contracts/extension/upgradeable/init/ReentrancyGuardInit.sol";
//import "../lib/contracts/contracts/extension/upgradeable/ContractMetadata.sol";
//import "../lib/contracts/contracts/extension/SignatureMintERC721Upgradeable.sol";

/**
 *  This smart contr    act is an EXAMPLE, and is not meant for use in production.
 */
contract SimpleRouter is
    BaseRouter//,
    //Initializable,
    //PermissionsEnumerable,
    //ReentrancyGuardInit,
    //ContractMetadata,
//SignatureMintERC721Upgradeable
{
    /// @dev Only EXTENSION_ROLE holders can perform upgrades.
    bytes32 private constant EXTENSION_ROLE = keccak256("EXTENSION_ROLE");


    //address public admin;
    address public tokenAddress;

//    constructor() BaseRouter(new Extension[](0)) {
//        admin = msg.sender;
//    }
    /// @dev We accept constructor params as a struct to avoid `Stack too deep` errors.
    struct PixotchiConstructorParams {
        Extension[] extensions;
        address tokenAddress;
    }

    constructor(
        PixotchiConstructorParams memory _pV3Params
    ) BaseRouter(_pV3Params.extensions) {
        tokenAddress = _pV3Params.tokenAddress;
        //_disableInitializers();
    //__SignatureMintERC721_init();
    }

//    // @dev Sets the admin address.
//    function setAdmin(address _admin) external {
//        require(msg.sender == admin, "RouterUpgradeable: Only admin can set a new admin");
//        admin = _admin;
//    }

    /*///////////////////////////////////////////////////////////////
                            Overrides
    //////////////////////////////////////////////////////////////*/

//    /// @dev Returns whether a function can be disabled in an extension in the given execution context.
//    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
//        return msg.sender == admin;
//    }

    receive() external payable {
        //assert(msg.sender == tokenAddress); // only accept ETH via fallback from the native token wrapper contract
    }

//    /// @dev Initializes the contract, like a constructor.
//    function initialize(
//        address _defaultAdmin,
//        string memory _contractURI
//    //address[] memory _trustedForwarders,
//    //address _platformFeeRecipient,
//    //uint16 _platformFeeBps
//    ) external initializer {
//        // Initialize BaseRouter
//        __BaseRouter_init();
//
////        // Initialize inherited contracts, most base-like -> most derived.
////        __ReentrancyGuard_init();
////        //__ERC2771Context_init(_trustedForwarders);
////
////        // Initialize this contract's state.
////        _setupContractURI(_contractURI);
////        //_setupPlatformFeeInfo(_platformFeeRecipient, _platformFeeBps);
////
////        _setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);
////        _setupRole(EXTENSION_ROLE, _defaultAdmin);
////        _setupRole(keccak256("LISTER_ROLE"), address(0));
////        _setupRole(keccak256("ASSET_ROLE"), address(0));
////
////        _setupRole(EXTENSION_ROLE, _defaultAdmin);
////        _setRoleAdmin(EXTENSION_ROLE, EXTENSION_ROLE);
//    }

    /*///////////////////////////////////////////////////////////////
                    Overridable Permissions
//////////////////////////////////////////////////////////////*/


//
//    /// @dev Checks whether contract metadata can be set in the given execution context.
//    function _canSetContractURI() internal view override returns (bool) {
//        return _hasRole(DEFAULT_ADMIN_ROLE, _msgSender());
//    }



//    /// @dev Checks whether an account has a particular role.
//    function _hasRole(bytes32 _role, address _account) internal view returns (bool) {
//        PermissionsStorage.Data storage data = PermissionsStorage.data();
//        return data._hasRole[_role][_account];
//    }

//    /// @dev Returns whether all relevant permission and other checks are met before any upgrade.
//    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
//        return _hasRole(EXTENSION_ROLE, msg.sender);
//    }

//    function _msgSender()
//    internal
//    view
//    override(ERC2771ContextUpgradeable, Permissions, Multicall)
//    returns (address sender)
//    {
//        return ERC2771ContextUpgradeable._msgSender();
//    }
//
//    function _msgData() internal view override(ERC2771ContextUpgradeable, Permissions) returns (bytes calldata) {
//        return ERC2771ContextUpgradeable._msgData();
//    }

}
