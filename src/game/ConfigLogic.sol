// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "./GameStorage.sol";
import "../IPixotchi.sol";

//import "../utils/ERC2771ContextConsumer.sol";
import "@openzeppelin/contracts/utils/Context.sol";

import "../utils/FixedPointMathLib.sol";
import "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
//import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
import "../../lib/contracts/contracts/eip/interface/IERC721A.sol";

contract ConfigLogic is
IConfig,
//ReentrancyGuard,
PermissionsEnumerable,
Initializable//,
{
    constructor(){

    }


    function setConfig(/*uint256 _Price, uint256 _maxSupply,*/ bool _mintIsActive, uint256 _burnPercentage) public onlyRole(DEFAULT_ADMIN_ROLE) {
        require(_burnPercentage <= 100, "Burn percentage can't be more than 100");
        //_s().Mint_Price = _Price;
        //_s().maxSupply = _maxSupply;
        _s().mintIsActive = _mintIsActive;
        _s().burnPercentage = _burnPercentage;
    }

    function setRenderer(address _renderer) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().renderer = IRenderer(_renderer);
    }

    function setRevShareWallet(address _revShareWallet) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().revShareWallet = _revShareWallet;
    }

    function setToken(address _token) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().token = IToken(_token);
    }

    /// @dev Returns the storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
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
