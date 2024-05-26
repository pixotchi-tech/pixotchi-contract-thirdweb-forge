// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @author pixotchi

//            $$\                       $$\               $$\       $$\
//            \__|                      $$ |              $$ |      \__|
//   $$$$$$\  $$\ $$\   $$\  $$$$$$\  $$$$$$\    $$$$$$$\ $$$$$$$\  $$\
//  $$  __$$\ $$ |\$$\ $$  |$$  __$$\ \_$$  _|  $$  _____|$$  __$$\ $$ |
//  $$ /  $$ |$$ | \$$$$  / $$ /  $$ |  $$ |    $$ /      $$ |  $$ |$$ |
//  $$ |  $$ |$$ | $$  $$<  $$ |  $$ |  $$ |$$\ $$ |      $$ |  $$ |$$ |
//  $$$$$$$  |$$ |$$  /\$$\ \$$$$$$  |  \$$$$  |\$$$$$$$\ $$ |  $$ |$$ |
//  $$  ____/ \__|\__/  \__| \______/    \____/  \_______|\__|  \__|\__|
//  $$ |
//  $$ |
//  \__|

// ====== Special thanks to ======

//   $$\     $$\       $$\                 $$\                         $$\
//   $$ |    $$ |      \__|                $$ |                        $$ |
// $$$$$$\   $$$$$$$\  $$\  $$$$$$\   $$$$$$$ |$$\  $$\  $$\  $$$$$$\  $$$$$$$\
// \_$$  _|  $$  __$$\ $$ |$$  __$$\ $$  __$$ |$$ | $$ | $$ |$$  __$$\ $$  __$$\
//   $$ |    $$ |  $$ |$$ |$$ |  \__|$$ /  $$ |$$ | $$ | $$ |$$$$$$$$ |$$ |  $$ |
//   $$ |$$\ $$ |  $$ |$$ |$$ |      $$ |  $$ |$$ | $$ | $$ |$$   ____|$$ |  $$ |
//   \$$$$  |$$ |  $$ |$$ |$$ |      \$$$$$$$ |\$$$$$\$$$$  |\$$$$$$$\ $$$$$$$  |
//    \____/ \__|  \__|\__|\__|       \_______| \_____\____/  \_______|\_______/

// ====== And to ======


//                     |"|                                       |"|      #                 # #   ___         _     _       _     _       |               ___
//       vvv          _|_|_       `  _ ,  '     `  _ ,  '       _|_|_     #=ooO=========Ooo=# #  <_*_>      o' \,=./ `o   o' \,=./ `o     |.===.         /\#/\
//      (0~0)         (o o)      -  (o)o)  -   -  (o)o)  -      (o o)     #  \\  (o o)  //  # #  (o o)         (o o)         (o o)        {}o o{}       /(o o)\
//  ooO--(_)--Ooo-ooO--(_)--Ooo--ooO'(_)--Ooo--ooO'(_)--Ooo-ooO--(_)--Ooo---------(_)---------8---(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-


//   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄
//  ▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌
//  ▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌     ▐░▌
//  ▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌     ▐░▌▐░▌    ▐░▌
//  ▐░▌       ▐░▌▐░▌ ▐░▌   ▐░▌▐░▌          ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌     ▐░▌     ▐░▌ ▐░▌   ▐░▌
//  ▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌     ▐░▌  ▐░▌  ▐░▌
//  ▐░▌       ▐░▌▐░▌   ▐░▌ ▐░▌▐░▌          ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌     ▐░▌     ▐░▌   ▐░▌ ▐░▌
//  ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌     ▐░▌    ▐░▌▐░▌
//  ▐░█▄▄▄▄▄▄▄█░▌▐░▌     ▐░▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░▌       ▐░▌ ▄▄▄▄█░█▄▄▄▄ ▐░▌     ▐░▐░▌
//  ▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌
//   ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀
//


//   ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄       ▄▄  ▄▄       ▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄
//  ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░▌     ▐░░▌▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
//  ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░▌░▌   ▐░▐░▌▐░▌░▌   ▐░▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌
//  ▐░▌          ▐░▌       ▐░▌▐░▌▐░▌ ▐░▌▐░▌▐░▌▐░▌ ▐░▌▐░▌▐░▌          ▐░▌       ▐░▌
//  ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░▌ ▐░▐░▌ ▐░▌▐░▌ ▐░▐░▌ ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌
//  ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
//   ▀▀▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌   ▀   ▐░▌▐░▌   ▀   ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀█░█▀▀
//            ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌     ▐░▌
//   ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌      ▐░▌
//  ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌
//   ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀
//


//import "@thirdweb-dev/dynamic-contracts/src/presets/BaseRouter.sol";
import {BaseRouter, IRouter, IRouterState} from "../../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/init/ReentrancyGuardInit.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ERC2771ContextUpgradeable.sol";
import "../utils/FixedPointMathLib.sol";

//import "../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";

import "../game/GameStorage.sol";


contract PixotchiRouter is
Initializable,
BaseRouter,
PermissionsEnumerable,
ReentrancyGuardInit,
ReentrancyGuard,
ERC2771ContextUpgradeable
//,
    //ERC721AUpgradeable
{
    /// @dev Only EXTENSION_ROLE holders can perform upgrades.
    bytes32 private constant EXTENSION_ROLE = keccak256("EXTENSION_ROLE");

    bytes32 private constant MODULE_TYPE = bytes32("PixotchiV2");
    uint256 private constant VERSION = 1;

    //address public tokenAddress;

    /// @dev We accept constructor params as a struct to avoid `Stack too deep` errors.
    struct SimpleRouterConstructorParams {
        Extension[] extensions;
        //address tokenAddress;
    }



    constructor(
        SimpleRouterConstructorParams memory _simpleRouterV3Params
    ) BaseRouter(_simpleRouterV3Params.extensions)  {
        __BaseRouter_init();
        //_disableInitializers();

    }

    receive() external payable {
        GameStorage.Data storage _s = GameStorage.data();
        _s.ethAccPerShare += FixedPointMathLib.mulDivDown(msg.value, _s.PRECISION, _s.totalScores);
    }

    /// @dev Initializes the contract, like a constructor.
    function initialize(
    ) external initializer {
        __ReentrancyGuard_init();
        address _defaultAdmin = 0xC3f88d5925d9aa2ccc7b6cb65c5F8c7626591Daf;
        _setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);
        _setupRole(EXTENSION_ROLE, _defaultAdmin);
        _setupRole(EXTENSION_ROLE, _defaultAdmin);
        _setRoleAdmin(EXTENSION_ROLE, EXTENSION_ROLE);
    }

    /*///////////////////////////////////////////////////////////////
                        Generic contract logic
    //////////////////////////////////////////////////////////////*/

    /// @dev Returns the type of the contract.
    function contractType() external pure returns (bytes32) {
        return MODULE_TYPE;
    }

    /// @dev Returns the version of the contract.
    function contractVersion() external pure returns (uint8) {
        return uint8(VERSION);
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

    function _msgSender()
    internal
    view
    override(ERC2771ContextUpgradeable, Permissions/*, Multicall*/)
    returns (address sender)
    {
        return ERC2771ContextUpgradeable._msgSender();
    }

    function _msgData() internal view override(ERC2771ContextUpgradeable, Permissions)
    returns (bytes calldata) {
        return ERC2771ContextUpgradeable._msgData();
    }

    function trustedForwarder() public view virtual returns (address) {
        return _trustedForwarder;
    }


}
//       ___________________________________________/\/\_
//      ___/\/\/\/\____/\/\/\______/\/\/\__________/\/\_
//     _/\/\/\/\____/\/\/\/\/\__/\/\/\/\/\____/\/\/\/\_
//    _______/\/\__/\/\________/\/\________/\/\__/\/\_
//   _/\/\/\/\______/\/\/\/\____/\/\/\/\____/\/\/\/\_
//  ________________________________________________
//  _____________/\/\______________________________/\/\_____________________________
//  _/\/\/\/\____/\/\____/\/\/\______/\/\/\/\____/\/\/\/\/\____/\/\/\____/\/\__/\/\_
//  _/\/\__/\/\__/\/\________/\/\____/\/\__/\/\____/\/\______/\/\/\/\/\__/\/\/\/\___
//  _/\/\/\/\____/\/\____/\/\/\/\____/\/\__/\/\____/\/\______/\/\________/\/\_______
//  _/\/\________/\/\/\__/\/\/\/\/\__/\/\__/\/\____/\/\/\______/\/\/\/\__/\/\_______
//  _/\/\___________________________________________________________________________
//       ____________________________________
//      ___/\/\/\/\____/\/\/\______/\/\/\___
//     _/\/\/\/\____/\/\/\/\/\__/\/\/\/\/\_
//    _______/\/\__/\/\________/\/\_______
//   _/\/\/\/\______/\/\/\/\____/\/\/\/\_
//  ____________________________________
//  ____________________________________
//  _/\/\__/\/\____/\/\/\____/\/\__/\/\_
//  _/\/\__/\/\__/\/\__/\/\__/\/\__/\/\_
//  ___/\/\/\/\__/\/\__/\/\__/\/\__/\/\_
//  _______/\/\____/\/\/\______/\/\/\/\_
//  _/\/\/\/\___________________________
//       ________________________
//      ___/\/\/\____/\/\/\/\___
//     _/\/\__/\/\__/\/\__/\/\_
//    _/\/\__/\/\__/\/\__/\/\_
//   ___/\/\/\____/\/\__/\/\_
//  ________________________
//  ___/\/\______/\/\___________________
//  _/\/\/\/\/\__/\/\__________/\/\/\___
//  ___/\/\______/\/\/\/\____/\/\/\/\/\_
//  ___/\/\______/\/\__/\/\__/\/\_______
//  ___/\/\/\____/\/\__/\/\____/\/\/\/\_
//  ____________________________________
//       _______________/\/\______/\/\_______________________________
//      ___/\/\/\____/\/\/\/\/\__/\/\__________/\/\/\____/\/\__/\/\_
//     _/\/\__/\/\____/\/\______/\/\/\/\____/\/\/\/\/\__/\/\/\/\___
//    _/\/\__/\/\____/\/\______/\/\__/\/\__/\/\________/\/\_______
//   ___/\/\/\______/\/\/\____/\/\__/\/\____/\/\/\/\__/\/\_______
//  ____________________________________________________________
//
//                 _______
//             .--.\  ___ `'.         __.....__
//             |__| ' |--.\  \    .-''         '.
//             .--. | |    \  '  /     .-''"'-.  `.
//             |  | | |     |  '/     /________\   \
//         _   |  | | |     |  ||                  |
//       .' |  |  | | |     ' .'\    .-------------'
//      .   | /|  | | |___.' /'  \    '-.____...---.
//    .'.'| |//|__|/_______.'/    `.             .'
//  .'.'.-'  /     \_______|/       `''-...... -'
//  .'   \_.'
//
