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
    /// @notice Emitted when a shop item is purchased.
    /// @param nftId The ID of the NFT.
    /// @param buyer The address of the buyer.
    /// @param itemId The ID of the purchased item.
    event ShopItemPurchased(uint256 indexed nftId, address indexed buyer, uint256 indexed itemId);

    /// @notice Reinitializes the ShopLogic contract.
    /// @dev This function is called to reinitialize the contract with new settings.
    function reinitializer_8_ShopLogic() public reinitializer(8) {
        _createShopItem("Fence", 50 * 10**18, 2 days, 0); // Assuming 0 for unlimited supply
    }

    /// @notice Creates a new shop item.
    /// @param name The name of the item.
    /// @param price The price of the item.
    /// @param expireTime The expiration time of the item.
    /// @param maxSupply The maximum supply of the item (0 for unlimited).
    function _createShopItem(
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
    function shopItemExists(uint256 itemId) public view returns (bool) {
        return bytes(_sS().shopItemName[itemId]).length > 0;
    }

    /// @notice Gets all shop items.
    /// @return ShopItem[] An array of all shop items.
    function getAllShopItem() public view returns (ShopItem[] memory) {
        uint256 itemCount = _sS().shopItemCounter;
        ShopItem[] memory items = new ShopItem[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            items[i] = ShopItem({
                id: i,
                name: _sS().shopItemName[i],
                price: _sS().shopItemPrice[i],
                ExpireTime: _sS().shopItemExpireTime[i]
            });
        }
        return items;
    }

    /// @notice Gets the purchased shop items for a specific NFT.
    /// @param nftId The ID of the NFT.
    /// @return ShopItemOwned[] An array of owned shop items.
    function getPurchasedShopItems(uint256 nftId) public view returns (ShopItemOwned[] memory) {
        ShopItemOwned[] memory ownedItems = new ShopItemOwned[](1);
        ownedItems[0] = ShopItemOwned({
            id: 0,
            name: _sS().shopItemName[0],
            EffectUntil: _sS().shop_0_Fence_EffectUntil[nftId]
        });
        return ownedItems;
    }

    /// @notice Buys a shop item.
    /// @param nftId The ID of the NFT.
    /// @param itemId The ID of the item to buy.
    function buyShopItem(uint256 nftId, uint256 itemId) external nonReentrant {
        require(shopItemExists(itemId), "This item doesn't exist");
        require(IGame(address(this)).isPlantAlive(nftId), "Plant is dead");
        require(IERC721A.IERC721A(address(this)).ownerOf(nftId) == msg.sender, "Not the owner");

        uint256 amount = _sS().shopItemPrice[itemId];

        // Check if the item is still active and not expired
        require(_sS().shopItemIsActive[itemId], "Item is not active");
        require(block.timestamp <= _sS().shopItemExpireTime[itemId], "Item has expired");

        // Check if the item has limited supply and if it's still available
        if (_sS().shopItemMaxSupply[itemId] > 0) {
            require(_sS().shopItemTotalConsumed[itemId] < _sS().shopItemMaxSupply[itemId], "Item is out of stock");
        }

        // Update the total consumed count
        _sS().shopItemTotalConsumed[itemId]++;

        // Handle the payment using delegatecall
        NFTLogicDelegations._tokenBurnAndRedistribute(address(this), msg.sender, amount);

        // Apply the item's effect (this part is hypothetical and should be adjusted based on your actual logic)
        _applyItemEffect(nftId, itemId);

        emit ShopItemPurchased(nftId, msg.sender, itemId);
    }

    /// @notice Applies the effect of a shop item to an NFT.
    /// @param nftId The ID of the NFT.
    /// @param itemId The ID of the item.
    function _applyItemEffect(uint256 nftId, uint256 itemId) internal {
        if (itemId == 0) {
            _sS().shop_0_Fence_EffectUntil[nftId] = block.timestamp + _sS().shopItemExpireTime[itemId];
        }
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
