// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./GameStorage.sol";
//import "../IPixotchi.sol";

//import "@openzeppelin/contracts/utils/Context.sol";

//import "../utils/FixedPointMathLib.sol";
//import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
//import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
//import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
//import "../../lib/contracts/contracts/eip/interface/IERC721A.sol";
import "../utils/PixotchiExtensionPermission.sol";

contract DebugLogic is PixotchiExtensionPermission {


//
//    function debugSetEthOwed(uint256 id, uint256 amount) public onlyAdminRole {
//        _s().ethOwed[id] = amount;
//    }
//
//    function debugGetEthOwed(uint256 id) public view returns (uint256) {
//        return _s().ethOwed[id];
//    }
//
//    function debugSetPlantRewardDebt(
//        uint256 id,
//        uint256 debt
//    ) public onlyAdminRole {
//        _s().plantRewardDebt[id] = debt;
//    }
//
//    function debugGetPlantRewardDebt(uint256 id) public view returns (uint256) {
//        return _s().plantRewardDebt[id];
//    }

function debugGetIdsByOwnerLength(address owner) public view returns (uint256) {
    return _s().idsByOwner[owner].length;
}

    function debugSetIdsByOwner(
        address owner,
        uint32[] memory ids
    ) public onlyAdminRole {
        _s().idsByOwner[owner] = ids;
    }

    function debugGetIdsByOwner(
        address owner
    ) public view returns (uint32[] memory) {
        return _s().idsByOwner[owner];
    }

    function debugSetOwnerIndexById(
        uint32 id,
        uint32 index
    ) public onlyAdminRole {
        _s().ownerIndexById[id] = index;
    }

    function debugGetOwnerIndexById(uint32 id) public view returns (uint32) {
        return _s().ownerIndexById[id];
    }

    function debugSetBurnedPlants(
        uint256 id,
        bool burned
    ) public onlyAdminRole {
        _s().burnedPlants[id] = burned;
    }

    function debugGetBurnedPlants(uint256 id) public view returns (bool) {
        return _s().burnedPlants[id];
    }

    // function debugSetShopItemPrice(
    //     uint256 id,
    //     uint256 price
    // ) public onlyAdminRole {
    //     _s().shopItemPrice[id] = price;
    // }

    // function debugGetShopItemPrice(uint256 id) public view returns (uint256) {
    //     return _s().shopItemPrice[id];
    // }

    // function debugSetShopItemTotalConsumed(
    //     uint256 id,
    //     uint256 totalConsumed
    // ) public onlyAdminRole {
    //     _s().shopItemTotalConsumed[id] = totalConsumed;
    // }

    // function debugGetShopItemTotalConsumed(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().shopItemTotalConsumed[id];
    // }

    // function debugSetShopItemMaxSupply(
    //     uint256 id,
    //     uint256 maxSupply
    // ) public onlyAdminRole {
    //     _s().shopItemMaxSupply[id] = maxSupply;
    // }

    // function debugGetShopItemMaxSupply(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().shopItemMaxSupply[id];
    // }

    // function debugSetShopItemName(
    //     uint256 id,
    //     string memory name
    // ) public onlyAdminRole {
    //     _s().shopItemName[id] = name;
    // }

    // function debugGetShopItemName(
    //     uint256 id
    // ) public view returns (string memory) {
    //     return _s().shopItemName[id];
    // }

    // function debugSetShopItemIsActive(
    //     uint256 id,
    //     bool isActive
    // ) public onlyAdminRole {
    //     _s().shopItemIsActive[id] = isActive;
    // }

    // function debugGetShopItemIsActive(uint256 id) public view returns (bool) {
    //     return _s().shopItemIsActive[id];
    // }

    // function debugSetShopItemExpireTime(
    //     uint256 id,
    //     uint256 expireTime
    // ) public onlyAdminRole {
    //     _s().shopItemExpireTime[id] = expireTime;
    // }

    // function debugGetShopItemExpireTime(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().shopItemExpireTime[id];
    // }

    // function debugSetPlantName(
    //     uint256 id,
    //     string memory name
    // ) public onlyAdminRole {
    //     _s().plantName[id] = name;
    // }

    // function debugGetPlantName(uint256 id) public view returns (string memory) {
    //     return _s().plantName[id];
    // }

    // function debugSetPlantTimeUntilStarving(
    //     uint256 id,
    //     uint256 timeUntilStarving
    // ) public onlyAdminRole {
    //     _s().plantTimeUntilStarving[id] = timeUntilStarving;
    // }

    // function debugGetPlantTimeUntilStarving(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().plantTimeUntilStarving[id];
    // }

    // function debugSetPlantScore(
    //     uint256 id,
    //     uint256 score
    // ) public onlyAdminRole {
    //     _s().plantScore[id] = score;
    // }

    // function debugGetPlantScore(uint256 id) public view returns (uint256) {
    //     return _s().plantScore[id];
    // }

    // function debugSetPlantTimeBorn(
    //     uint256 id,
    //     uint256 timeBorn
    // ) public onlyAdminRole {
    //     _s().plantTimeBorn[id] = timeBorn;
    // }

    // function debugGetPlantTimeBorn(uint256 id) public view returns (uint256) {
    //     return _s().plantTimeBorn[id];
    // }

    // function debugSetPlantLastAttackUsed(
    //     uint256 id,
    //     uint256 lastAttackUsed
    // ) public onlyAdminRole {
    //     _s().plantLastAttackUsed[id] = lastAttackUsed;
    // }

    // function debugGetPlantLastAttackUsed(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().plantLastAttackUsed[id];
    // }

    // function debugSetPlantLastAttacked(
    //     uint256 id,
    //     uint256 lastAttacked
    // ) public onlyAdminRole {
    //     _s().plantLastAttacked[id] = lastAttacked;
    // }

    // function debugGetPlantLastAttacked(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().plantLastAttacked[id];
    // }

    // function debugSetPlantStars(
    //     uint256 id,
    //     uint256 stars
    // ) public onlyAdminRole {
    //     _s().plantStars[id] = stars;
    // }

    // function debugGetPlantStars(uint256 id) public view returns (uint256) {
    //     return _s().plantStars[id];
    // }

    // function debugSetPlantStrain(
    //     uint256 id,
    //     uint256 strain
    // ) public onlyAdminRole {
    //     _s().plantStrain[id] = strain;
    // }

    // function debugGetPlantStrain(uint256 id) public view returns (uint256) {
    //     return _s().plantStrain[id];
    // }

    // function debugSetShop_0_Fence_EffectUntil(
    //     uint256 id,
    //     uint256 effectUntil
    // ) public onlyAdminRole {
    //     _s().shop_0_Fence_EffectUntil[id] = effectUntil;
    // }

    // function debugGetShop_0_Fence_EffectUntil(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().shop_0_Fence_EffectUntil[id];
    // }

    // function debugSetPrecision(uint256 _precision) public onlyAdminRole {
    //     _s().PRECISION = _precision;
    // }

    // function debugGetPrecision() public view returns (uint256) {
    //     return _s().PRECISION;
    // }

    // function debugSetToken(address _token) public onlyAdminRole {
    //     _s().token = IToken(_token);
    // }

    // function debugGetToken() public view returns (address) {
    //     return address(_s().token);
    // }

    // function debugSetItemPrice(uint256 id, uint256 price) public onlyAdminRole {
    //     _s().itemPrice[id] = price;
    // }

    // function debugGetItemPrice(uint256 id) public view returns (uint256) {
    //     return _s().itemPrice[id];
    // }

    // function debugSetItemPoints(
    //     uint256 id,
    //     uint256 points
    // ) public onlyAdminRole {
    //     _s().itemPoints[id] = points;
    // }

    // function debugGetItemPoints(uint256 id) public view returns (uint256) {
    //     return _s().itemPoints[id];
    // }

    // function debugSetItemName(
    //     uint256 id,
    //     string memory name
    // ) public onlyAdminRole {
    //     _s().itemName[id] = name;
    // }

    // function debugGetItemName(uint256 id) public view returns (string memory) {
    //     return _s().itemName[id];
    // }

    // function debugSetItemTimeExtension(
    //     uint256 id,
    //     uint256 timeExtension
    // ) public onlyAdminRole {
    //     _s().itemTimeExtension[id] = timeExtension;
    // }

    // function debugGetItemTimeExtension(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().itemTimeExtension[id];
    // }

    // function debugSetMintIsActive(bool _mintIsActive) public onlyAdminRole {
    //     _s().mintIsActive = _mintIsActive;
    // }

    // function debugGetMintIsActive() public view returns (bool) {
    //     return _s().mintIsActive;
    // }

    // function debugSetRevShareWallet(
    //     address _revShareWallet
    // ) public onlyAdminRole {
    //     _s().revShareWallet = _revShareWallet;
    // }

    // function debugGetRevShareWallet() public view returns (address) {
    //     return _s().revShareWallet;
    // }

    // function debugSetBurnPercentage(
    //     uint256 _burnPercentage
    // ) public onlyAdminRole {
    //     require(
    //         _burnPercentage <= 100,
    //         "Burn percentage can't be more than 100"
    //     );
    //     _s().burnPercentage = _burnPercentage;
    // }

    // function debugGetBurnPercentage() public view returns (uint256) {
    //     return _s().burnPercentage;
    // }

    // function debugSetRenderer(address _renderer) public onlyAdminRole {
    //     _s().renderer = IRenderer(_renderer);
    // }

    // function debugGetRenderer() public view returns (address) {
    //     return address(_s().renderer);
    // }

    // function debugSetStrainCounter(
    //     uint256 _strainCounter
    // ) public onlyAdminRole {
    //     _s().strainCounter = _strainCounter;
    // }

    // function debugGetStrainCounter() public view returns (uint256) {
    //     return _s().strainCounter;
    // }

    // function debugSetMintPriceByStrain(
    //     uint256 id,
    //     uint256 price
    // ) public onlyAdminRole {
    //     _s().mintPriceByStrain[id] = price;
    // }

    // function debugGetMintPriceByStrain(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().mintPriceByStrain[id];
    // }

    // function debugSetStrainBurned(
    //     uint256 id,
    //     uint256 burned
    // ) public onlyAdminRole {
    //     _s().strainBurned[id] = burned;
    // }

    // function debugGetStrainBurned(uint256 id) public view returns (uint256) {
    //     return _s().strainBurned[id];
    // }

    // function debugSetStrainTotalMinted(
    //     uint256 id,
    //     uint256 totalMinted
    // ) public onlyAdminRole {
    //     _s().strainTotalMinted[id] = totalMinted;
    // }

    // function debugGetStrainTotalMinted(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().strainTotalMinted[id];
    // }

    // function debugSetStrainMaxSupply(
    //     uint256 id,
    //     uint256 maxSupply
    // ) public onlyAdminRole {
    //     _s().strainMaxSupply[id] = maxSupply;
    // }

    // function debugGetStrainMaxSupply(uint256 id) public view returns (uint256) {
    //     return _s().strainMaxSupply[id];
    // }

    // function debugSetStrainName(
    //     uint256 id,
    //     string memory name
    // ) public onlyAdminRole {
    //     _s().strainName[id] = name;
    // }

    // function debugGetStrainName(
    //     uint256 id
    // ) public view returns (string memory) {
    //     return _s().strainName[id];
    // }

    // function debugSetStrainIsActive(
    //     uint256 id,
    //     bool isActive
    // ) public onlyAdminRole {
    //     _s().strainIsActive[id] = isActive;
    // }

    // function debugGetStrainIsActive(uint256 id) public view returns (bool) {
    //     return _s().strainIsActive[id];
    // }

    // function debugSetStrainIPFSHash(
    //     uint256 id,
    //     string memory ipfsHash
    // ) public onlyAdminRole {
    //     _s().strainIPFSHash[id] = ipfsHash;
    // }

    // function debugGetStrainIPFSHash(
    //     uint256 id
    // ) public view returns (string memory) {
    //     return _s().strainIPFSHash[id];
    // }

    // function debugSetStrainInitialTOD(
    //     uint256 id,
    //     uint256 initialTOD
    // ) public onlyAdminRole {
    //     _s().strainInitialTOD[id] = initialTOD;
    // }

    // function debugGetStrainInitialTOD(
    //     uint256 id
    // ) public view returns (uint256) {
    //     return _s().strainInitialTOD[id];
    // }

    /// @dev Returns the storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }
}
