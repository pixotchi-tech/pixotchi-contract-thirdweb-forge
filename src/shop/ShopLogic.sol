// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Internal imports
import "../game/GameStorage.sol";
import "../IPixotchi.sol";
import "../nft/NFTLogicDelegations.sol";
import "../utils/PixotchiExtensionPermission.sol";
import "./ShopStorage.sol";

// External imports
//import * as FixedPointMathLib from "../utils/FixedPointMathLib.sol";
import { PermissionsEnumerable } from "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import { ReentrancyGuard } from "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import { Initializable } from "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
import * as IERC721A from "../../lib/contracts/contracts/eip/interface/IERC721A.sol";

/// @title ShopLogic Contract
/// @notice This contract handles the logic for the shop in the game.
/// @dev Implements the IShop interface and uses various imported libraries and contracts.
contract ShopLogic is
IShop,
ReentrancyGuard,
Initializable,
PixotchiExtensionPermission
{

    /// @notice Reinitializes the ShopLogic contract.
    /// @dev This function is called to reinitialize the contract with new settings.
    function reinitializer_8_ShopLogic() public reinitializer(8) {
        _shopCreateItem("Fence", 50 * 10**18, 2 days, 0); // Assuming 0 for unlimited supply
    }

    /// @notice Creates a new shop item.
    /// @param name The name of the item.
    /// @param price The price of the item.
    /// @param expireTime The expiration time of the item.
    /// @param maxSupply The maximum supply of the item (0 for unlimited).
    function _shopCreateItem(
        string memory name,
        uint256 price,
        uint256 expireTime,
        uint256 maxSupply
    ) private {
        uint256 newItemId = _sS().shopItemCounter++;
        _sS().shopItemName[newItemId] = name;
        _sS().shopItemPrice[newItemId] = price;
        _sS().shopItemExpireTime[newItemId] = expireTime;
        _sS().shopItemIsActive[newItemId] = true;
        _sS().shopItemTotalConsumed[newItemId] = 0;
        _sS().shopItemMaxSupply[newItemId] = maxSupply; // 0 = Unlimited supply
        emit ShopItemCreated(newItemId, name, price, expireTime);
    }

    /// @notice Checks if a shop item exists.
    /// @param itemId The ID of the item.
    /// @return bool True if the item exists, false otherwise.
    function shopDoesItemExist(uint256 itemId) public view returns (bool) {
        return bytes(_sS().shopItemName[itemId]).length > 0;
    }

    /// @notice Gets all shop items.
    /// @return ShopItem[] An array of all shop items.
    function shopGetAllItems() public view returns (ShopItem[] memory) {
        uint256 itemCount = _sS().shopItemCounter;
        ShopItem[] memory items = new ShopItem[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            items[i] = ShopItem({
                id: i,
                name: _sS().shopItemName[i],
                price: _sS().shopItemPrice[i],
                expireTime: _sS().shopItemExpireTime[i]
            });
        }
        return items;
    }

    /// @notice Gets the purchased shop items for a specific NFT.
    /// @param nftId The ID of the NFT.
    /// @return ShopItemOwned[] An array of owned shop items.
    function shopGetPurchasedItems(uint256 nftId) public view returns (ShopItemOwned[] memory) {
        ShopItemOwned[] memory ownedItems = new ShopItemOwned[](1);
        ownedItems[0] = ShopItemOwned({
            id: 0,
            name: _sS().shopItemName[0],
            effectUntil: _sS().shop_0_Fence_EffectUntil[nftId]
        });
        return ownedItems;
    }

    /// @notice Checks if the effect of a shop item is still ongoing for an NFT.
    /// @param nftId The ID of the NFT.
    /// @param itemId The ID of the item.
    /// @return bool True if the effect is still ongoing, false otherwise.
    function shopIsEffectOngoing(uint256 nftId, uint256 itemId) public view returns (bool) {
        if (itemId == 0) {
            return block.timestamp <= _sS().shop_0_Fence_EffectUntil[nftId];
        }
        // Add more conditions here for different itemIds
        return false;
    }

    /// @notice Buys a shop item.
    /// @param nftId The ID of the NFT.
    /// @param itemId The ID of the item to buy.
    function shopBuyItem(uint256 nftId, uint256 itemId) external nonReentrant {
        require(shopDoesItemExist(itemId), "This item doesn't exist");
        require(IGame(address(this)).isPlantAlive(nftId), "Plant is dead");
        require(IERC721A.IERC721A(address(this)).ownerOf(nftId) == msg.sender, "Not the owner");

        uint256 amount = _sS().shopItemPrice[itemId];

        // Check if the item is still active and not expired
        require(_sS().shopItemIsActive[itemId], "Item is not active");
        if (_sS().shopItemExpireTime[itemId] != 0) {
            require(block.timestamp <= _sS().shopItemExpireTime[itemId], "Item has expired");
        }

        // Check if the item has limited supply and if it's still available
        if (_sS().shopItemMaxSupply[itemId] > 0) {
            require(_sS().shopItemTotalConsumed[itemId] < _sS().shopItemMaxSupply[itemId], "Item is out of stock");
        }

        // Prevent repurchase if the effect is still ongoing
        require(!shopIsEffectOngoing(nftId, itemId), "Effect still ongoing");

        NFTLogicDelegations._tokenBurnAndRedistribute(address(this), msg.sender, amount);

        // Increment the total consumed count for the item
        _sS().shopItemTotalConsumed[itemId]++;

        // Apply the item's effect
        _shopApplyItemEffect(nftId, itemId);

        emit ShopItemPurchased(nftId, msg.sender, itemId);
    }

    /// @notice Applies the effect of a shop item to an NFT.
    /// @param nftId The ID of the NFT.
    /// @param itemId The ID of the item.
    function _shopApplyItemEffect(uint256 nftId, uint256 itemId) internal {
        if (itemId == 0) {
            _sS().shop_0_Fence_EffectUntil[nftId] = block.timestamp + _sS().shopItemEffectTime[itemId];
        }
        // Add more conditions here for different itemIds
    }

    /// @dev Returns the storage.
    function _sG() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }

    /// @dev Returns the storage.
    function _sS() internal pure returns (ShopStorage.Data storage data) {
        data = ShopStorage.data();
    }
}
