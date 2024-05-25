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
        mapping(uint256 => uint256) strainTotalSupply;
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
        mapping(address => string) plantName;
        mapping(address => uint256) plantTimeUntilStarving;
        mapping(address => uint256) plantScore;
        mapping(address => uint256) plantTimeBorn;
        mapping(address => uint256) plantLastAttackUsed;
        mapping(address => uint256) plantLastAttacked;
        mapping(address => uint256) plantStars;
        mapping(address => uint256) plantStrain;
    }

    function data() internal pure returns (Data storage data_) {
        bytes32 position = OFFERS_STORAGE_POSITION;
        assembly {
            data_.slot := position
        }
    }

function createPlant(IGameLogic.Plant memory plant, ) internal {
    Data storage ds = data();
    ds.plantName[plant.] = plant.name;
    ds.plantStrain[plant.id] = plant.strain;
    ds.plantTimeBorn[plant.id] = block.timestamp;
    ds.plantTimeUntilStarving[plant.id] = plant.timeUntilStarving;
    ds.plantScore[plant.id] = plant.score;
    ds.plantLastAttackUsed[plant.id] = plant.lastAttackUsed;
    ds.plantLastAttacked[plant.id] = plant.lastAttacked;
    ds.plantStars[plant.id] = plant.stars;

    // Print updates
    //emit PlantUpdated(plant.owner, plant.name, plant.strain, plant.timeUntilStarving, plant.score, plant.lastAttackUsed, plant.lastAttacked, plant.stars);
}

function createItem(IGameLogic.FullItem memory item) internal {
    Data storage ds = data();
    ds.itemName[item.id] = item.name;
    ds.itemPrice[item.id] = item.price;
    ds.itemPoints[item.id] = item.points;
    ds.itemTimeExtension[item.id] = item.timeExtension;

    // Print updates
    //emit ItemUpdated(item.id, item.name, item.price, item.points, item.timeExtension);
}

    function getPlant(address owner)
    internal
    view
    returns (IGameLogic.Plant memory)
    {
        Data storage ds = data();
        return IGameLogic.Plant({
            name: ds.plantName[owner],
            timeUntilStarving: ds.plantTimeUntilStarving[owner],
            score: ds.plantScore[owner],
            timePlantBorn: ds.plantTimeBorn[owner],
            lastAttackUsed: ds.plantLastAttackUsed[owner],
            lastAttacked: ds.plantLastAttacked[owner],
            stars: ds.plantStars[owner],
            strain: ds.plantStrain[owner]
        });
    }

    function createShopItem(
        uint256 id,
        string memory name,
        uint256 price,
        uint256 maxSupply,
        uint256 expireTime
    ) internal {
        Data storage ds = data();
        ds.shopItemName[id] = name;
        ds.shopItemPrice[id] = price;
        ds.shopItemMaxSupply[id] = maxSupply;
        ds.shopItemExpireTime[id] = expireTime;
        ds.shopItemIsActive[id] = true;
        ds.shopItemTotalConsumed[id] = 0;
    }

    function getShopItem(uint256 id)
    internal
    view
    returns (
        string memory name,
        uint256 price,
        uint256 maxSupply,
        uint256 expireTime,
        bool isActive,
        uint256 totalConsumed
    )
    {
        Data storage ds = data();
        name = ds.shopItemName[id];
        price = ds.shopItemPrice[id];
        maxSupply = ds.shopItemMaxSupply[id];
        expireTime = ds.shopItemExpireTime[id];
        isActive = ds.shopItemIsActive[id];
        totalConsumed = ds.shopItemTotalConsumed[id];
    }


    function setStrain(
        uint256 id,
        uint256 mintPrice,
        uint256 totalSupply,
        uint256 totalMinted,
        uint256 maxSupply,
        string memory name,
        bool isActive
    ) internal {
        Data storage ds = data();
        ds.mintPriceByStrain[id] = mintPrice;
        ds.strainTotalSupply[id] = totalSupply;
        ds.strainTotalMinted[id] = totalMinted;
        ds.strainMaxSupply[id] = maxSupply;
        ds.strainName[id] = name;
        ds.strainIsActive[id] = isActive;
    }

    function getStrain(uint256 id) internal view returns (IGameLogic.Strain memory) {
        Data storage ds = data();
        return IGameLogic.Strain({
            id: id,
            mintPrice: ds.mintPriceByStrain[id],
            totalSupply: ds.strainTotalSupply[id],
            totalMinted: ds.strainTotalMinted[id],
            maxSupply: ds.strainMaxSupply[id],
            name: ds.strainName[id],
            isActive: ds.strainIsActive[id]
        });
    }

}
