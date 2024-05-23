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
        IToken  token;

        uint256 _tokenIds;
        uint256 _itemIds;

        uint256 la;
        uint256 lb;
        //uint256 totalOffers;
        //mapping(uint256 => IOffers.Offer) offers;
        mapping(uint256 => IGameLogic.Plant) plants;

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
        uint256 Mint_Price;
        uint256 hasTheDiamond;
        uint256 maxSupply;
        bool mintIsActive;
        address revShareWallet;
        uint256 burnPercentage;

        IRenderer renderer;

        mapping(uint256 => bool) burnedPlants;

    }

    function data() internal pure returns (Data storage data_) {
        bytes32 position = OFFERS_STORAGE_POSITION;
        assembly {
            data_.slot := position
        }
    }
}
