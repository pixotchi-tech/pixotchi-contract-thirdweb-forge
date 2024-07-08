// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./GameStorage.sol";
import "./DebugStorage.sol";
import "./../nft/ERC721AExtension.sol";
//import "../IPixotchi.sol";

//import "@openzeppelin/contracts/utils/Context.sol";

//import "../utils/FixedPointMathLib.sol";
//import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
//import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
//import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
//import "../../lib/contracts/contracts/eip/interface/IERC721A.sol";
import "../utils/PixotchiExtensionPermission.sol";



contract AirdropLogic is PixotchiExtensionPermission {

    /// @notice Returns an array of token IDs for all alive plants
    /// @return An array of uint256 representing the token IDs of alive plants
    function airdropGetAliveTokenIds() public view returns (uint256[] memory) {
        uint256 currentIndex = _sN()._currentIndex;
        uint256[] memory aliveTokenIds = new uint256[](currentIndex);
        uint256 aliveCount = 0;
        uint256 timestamp = block.timestamp;

        for (uint256 i = 0; i < currentIndex; i++) {
            if (!_sN()._ownerships[i].burned) {
                uint256 timeUntilStarving = _sG().plantTimeUntilStarving[i];
                if (timeUntilStarving != 0 && timeUntilStarving >= timestamp) {
                    aliveTokenIds[aliveCount++] = i;
                }
            }
        }

        // Resize the array to fit only the alive tokens
        assembly {
            mstore(aliveTokenIds, aliveCount)
        }

        return aliveTokenIds;
    }


    /// @dev Returns the GameStorage.
    function _sG() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }

        /// @dev Returns the ERC721AStorage.
    function _sN() internal pure returns (ERC721AStorage.Data storage data) {
        data = ERC721AStorage.erc721AStorage();
    }


}