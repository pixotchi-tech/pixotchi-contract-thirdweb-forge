// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ====== Internal imports ======
import "../game/GameStorage.sol";
import "../IPixotchi.sol";

// ====== External imports ======
import "../utils/FixedPointMathLib.sol";
import "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
//import "../../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";
import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
import "../../lib/contracts/contracts/eip/interface/IERC721A.sol";

contract ShopLogic is
IShop,
ReentrancyGuard,
//PermissionsEnumerable,
Initializable
{
    function initializeShopLogic() public reinitializer(5) {
        // Initialization logic
    }

    function createShopItem(
        string calldata name,
        uint256 price,
        uint256 _ExpireTime
    ) public {
        uint256 newItemId = _s().shopItemCounter++;
        _s().shopItemName[newItemId] = name;
        _s().shopItemPrice[newItemId] = price;
        _s().shopItemExpireTime[newItemId] = _ExpireTime;
        _s().shopItemIsActive[newItemId] = true;
        _s().shopItemTotalConsumed[newItemId] = 0;
        emit ShopItemCreated(newItemId, name, price, _ExpireTime);
    }

    function shopItemExists(uint256 itemId) public view returns (bool) {
        return bytes(_s().shopItemName[itemId]).length > 0;
    }

    function getAllShopItem() public view returns (ShopItem[] memory) {
        uint256 itemCount = _s().shopItemCounter;
        ShopItem[] memory items = new ShopItem[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            items[i] = ShopItem({
                id: i,
                name: _s().shopItemName[i],
                price: _s().shopItemPrice[i],
                ExpireTime: _s().shopItemExpireTime[i]
            });
        }
        return items;
    }

    function getPurchasedShopItems(uint256 nftId) public view returns (ShopItemOwned[] memory) {
        uint32[] storage ownedIds = _s().idsByOwner[msg.sender];
        ShopItemOwned[] memory ownedItems = new ShopItemOwned[](ownedIds.length);
        for (uint256 i = 0; i < ownedIds.length; i++) {
            uint256 itemId = ownedIds[i];
            ownedItems[i] = ShopItemOwned({
                id: itemId,
                name: _s().shopItemName[itemId],
                EffectUntil: _s().shop_0_Fence_EffectUntil[itemId]
            });
        }
        return ownedItems;
    }

    /// @dev Returns the storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }
}

