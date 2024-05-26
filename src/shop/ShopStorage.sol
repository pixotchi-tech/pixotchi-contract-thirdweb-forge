// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "../IPixotchi.sol";
import "../IRenderer.sol";
import "../IToken.sol";

/// @author thirdweb

//import { IOffers } from "../IMarketplace.sol";

/**
 * @author  thirdweb.com
 */
library GameStorage {
    /// @custom:storage-location erc7201:offers.storage
    /// @dev use chisel cli tool from foundry to evaluate this expression
    /// @dev  keccak256(abi.encode(uint256(keccak256("eth.pixotchi.game.storage")) - 1)) & ~bytes32(uint256(0xff))
    //bytes32  constant OFFERS_STORAGE_POSITION = keccak256(abi.encode(uint256(keccak256("eth.pixotchi.game.storage")) - 1));// & ~bytes32(uint256(0xff));
    //0x7b88e42357d22f249e6991bc87bae4cbb3c3a6df3597089b20afdf487007e800;
    bytes32  constant OFFERS_STORAGE_POSITION = 0xc7fc9545a7a1c6d926eb226aca9b0331d15be911879e1d18bd76f146a8dc0000; //keccak256(abi.encode(uint256(keccak256("eth.pixotchi.game.storage")) - 1))  & ~bytes32(uint256(0xff))


    struct Data {
        uint256 PRECISION;// = 1 ether;
        IToken token;

        //uint256 _tokenIds;
        uint256 _itemIds;

        uint256 la;
        uint256 lb;

        // v staking
        mapping(uint256 => uint256) ethOwed;
        mapping(uint256 => uint256) plantRewardDebt;

        uint256 ethAccPerShare;

        uint256 totalScores;

        // items/benefits for the plant, general so can be food or anything in the future.
        mapping(uint256 => uint256) itemPrice;
        mapping(uint256 => uint256) itemPoints;
        mapping(uint256 => string) itemName;
        mapping(uint256 => uint256) itemTimeExtension;
        mapping(address => uint32[]) idsByOwner;
        mapping(uint32 => uint32) ownerIndexById;

        mapping(address => bool) IsAuthorized;

        uint256 hasTheDiamond;
        //uint256 maxSupply;
        bool mintIsActive;
        address revShareWallet;
        uint256 burnPercentage;

        IRenderer renderer;

        mapping(uint256 => bool) burnedPlants;

        //strainCounter
        //uint256 strainCounter;
        mapping(uint256 => uint256) mintPriceByStrain;
        //mapping(uint256 => uint256) strainTotalSupply;
        mapping(uint256 => uint256) strainBurned;
        mapping(uint256 => uint256) strainTotalMinted;
        mapping(uint256 => uint256) strainMaxSupply;
        mapping(uint256 => string) strainName;
        mapping(uint256 => bool) strainIsActive;

        //shop Items
        uint256 shopItemCounter;
        mapping(uint256 => uint256) shopItemPrice;
        mapping(uint256 => uint256) shopItemTotalConsumed;
        mapping(uint256 => uint256) shopItemMaxSupply;
        mapping(uint256 => string) shopItemName;
        mapping(uint256 => bool) shopItemIsActive;
        mapping(uint256 => uint256) shopItemExpireTime;

        // Plant mappings
        mapping(uint256 => string) plantName;
        mapping(uint256 => uint256) plantTimeUntilStarving;
        mapping(uint256 => uint256) plantScore;
        mapping(uint256 => uint256) plantTimeBorn;
        mapping(uint256 => uint256) plantLastAttackUsed;
        mapping(uint256 => uint256) plantLastAttacked;
        mapping(uint256 => uint256) plantStars;
        mapping(uint256 => uint256) plantStrain;

        //mapping(uint256 => bool) approvedToBurn;

        bool guardDisarmed;

        // Shop mappings
        mapping(uint256 => uint256) shop_0_Fence_EffectUntil;
    }

    function data() internal pure returns (Data storage data_) {
        bytes32 position = OFFERS_STORAGE_POSITION;
        assembly {
            data_.slot := position
        }
    }

//    function createPlant(IGameLogic.Plant memory plant, uint256 id) internal {
//        Data storage ds = data();
//        ds.plantName[id] = plant.name;
//        ds.plantStrain[id] = plant.strain;
//        ds.plantTimeBorn[id] = block.timestamp;
//        ds.plantTimeUntilStarving[id] = plant.timeUntilStarving;
//        ds.plantScore[id] = plant.score;
//        ds.plantLastAttackUsed[id] = plant.lastAttackUsed;
//        ds.plantLastAttacked[id] = plant.lastAttacked;
//        ds.plantStars[id] = plant.stars;
//
//        // Print updates
//        //emit PlantUpdated(plant.owner, plant.name, plant.strain, plant.timeUntilStarving, plant.score, plant.lastAttackUsed, plant.lastAttacked, plant.stars);
//    }
//
//
//
//    function getPlant(uint256 id)
//    internal
//    view
//    returns (IGameLogic.Plant memory)
//    {
//        Data storage ds = data();
//        return IGameLogic.Plant({
//            name: ds.plantName[id],
//            timeUntilStarving: ds.plantTimeUntilStarving[id],
//            score: ds.plantScore[id],
//            timePlantBorn: ds.plantTimeBorn[id],
//            lastAttackUsed: ds.plantLastAttackUsed[id],
//            lastAttacked: ds.plantLastAttacked[id],
//            stars: ds.plantStars[id],
//            strain: ds.plantStrain[id]
//        });
//    }
//
//    function createShopItem(
//        uint256 id,
//        string memory name,
//        uint256 price,
//        uint256 maxSupply,
//        uint256 expireTime
//    ) internal {
//        Data storage ds = data();
//        ds.shopItemName[id] = name;
//        ds.shopItemPrice[id] = price;
//        ds.shopItemMaxSupply[id] = maxSupply;
//        ds.shopItemExpireTime[id] = expireTime;
//        ds.shopItemIsActive[id] = true;
//        ds.shopItemTotalConsumed[id] = 0;
//    }
//
//    function getShopItem(uint256 id)
//    internal
//    view
//    returns (
//        string memory name,
//        uint256 price,
//        uint256 maxSupply,
//        uint256 expireTime,
//        bool isActive,
//        uint256 totalConsumed
//    )
//    {
//        Data storage ds = data();
//        name = ds.shopItemName[id];
//        price = ds.shopItemPrice[id];
//        maxSupply = ds.shopItemMaxSupply[id];
//        expireTime = ds.shopItemExpireTime[id];
//        isActive = ds.shopItemIsActive[id];
//        totalConsumed = ds.shopItemTotalConsumed[id];
//    }
//
//
//    function setStrain(
//        uint256 id,
//        uint256 mintPrice,
//        //uint256 totalSupply,
//        //uint256 totalMinted,
//        uint256 maxSupply,
//        string memory name,
//        bool isActive
//    ) internal {
//        Data storage ds = data();
//        ds.mintPriceByStrain[id] = mintPrice;
//        //ds.strainTotalSupply[id] = totalSupply;
//        //ds.strainTotalMinted[id] = totalMinted;
//        ds.strainMaxSupply[id] = maxSupply;
//        ds.strainName[id] = name;
//        ds.strainIsActive[id] = isActive;
//    }
//
//    function getStrain(uint256 id) internal view returns (IGameLogic.Strain memory) {
//        Data storage ds = data();
//        return IGameLogic.Strain({
//            id: id,
//            mintPrice: ds.mintPriceByStrain[id],
//            totalSupply: getStrainTotalSupply(id),
//            getStrainTotalLeft: getStrainTotalLeft(id),
//            totalMinted: ds.strainTotalMinted[id],
//            maxSupply: ds.strainMaxSupply[id],
//            name: ds.strainName[id],
//            isActive: ds.strainIsActive[id]
//        });
//    }
//
//    function getStrainTotalSupply(uint256 id) internal view returns (uint256) {
//        Data storage ds = data();
//        return ds.strainTotalMinted[id] - ds.strainBurned[id];
//    }
//
//    function getStrainTotalLeft(uint256 id) internal view returns (uint256) {
//        Data storage ds = data();
//        return ds.strainMaxSupply[id] - ds.strainTotalMinted[id];
//    }

}
