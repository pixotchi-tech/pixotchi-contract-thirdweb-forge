// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// ====== Internal imports ======
import "../game/GameStorage.sol";
import "../IPixotchi.sol";
import "../nft/NFTLogicDelegations.sol";

// ====== External imports ======
import "../utils/FixedPointMathLib.sol";
import "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
//import "../../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";
import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
import "../../lib/contracts/contracts/eip/interface/IERC721A.sol";
import "../utils/PixotchiExtensionPermission.sol";
import "./ShopStorage.sol";

contract ShopLogic is
IShop,
ReentrancyGuard,
Initializable,
PixotchiExtensionPermission
{
    event ShopItemPurchased(uint256 indexed nftId, address indexed buyer, uint256 indexed itemId);

    function reinitializer_8_ShopLogic() public reinitializer(8) {
        
    }

    function initializeFirstShopItem() public initializer {
        _createShopItem("Fence", 50 * 10**18, 2 days, 0); // Assuming 0 for unlimited supply
    }

    function _createShopItem(
        string memory name,
        uint256 price,
        uint256 _ExpireTime,
        uint256 _MaxSupply
    ) private {
        uint256 newItemId = _sS().shopItemCounter++;
        _sS().shopItemName[newItemId] = name;
        _sS().shopItemPrice[newItemId] = price;
        _sS().shopItemExpireTime[newItemId] = _ExpireTime;
        _sS().shopItemIsActive[newItemId] = true;
        _sS().shopItemTotalConsumed[newItemId] = 0;
        _sS().shopItemMaxSupply[newItemId] = _MaxSupply; // 0 = Unlimited supply
        emit ShopItemCreated(newItemId, name, price, _ExpireTime);
    }

    function shopItemExists(uint256 itemId) public view returns (bool) {
        return bytes(_sS().shopItemName[itemId]).length > 0;
    }

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

    function getPurchasedShopItems(uint256 nftId) public view returns (ShopItemOwned[] memory) {
        ShopItemOwned[] memory ownedItems = new ShopItemOwned[](1);
        ownedItems[0] = ShopItemOwned({
            id: 0,
            name: _sS().shopItemName[0],
            EffectUntil: _sS().shop_0_Fence_EffectUntil[nftId]
        });
        return ownedItems;
    }

    function buyShopItem(uint256 nftId, uint256 itemId) external nonReentrant {
        require(shopItemExists(itemId), "This item doesn't exist");
        require(IGame(address(this)).isPlantAlive(nftId), "Plant is dead");
        require(IERC721A(address(this)).ownerOf(nftId) == msg.sender, "Not the owner");

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
        NFTLogicDelegations._delegateTokenBurnAndRedistribute(address(this), msg.sender, amount);

        // Example usage of delegateWithReturnValue
        // bytes memory result = NFTLogicDelegations.delegateWithReturnValue(address(this), msg.sender, amount);
        // Process the result if needed

        // Apply the item's effect (this part is hypothetical and should be adjusted based on your actual logic)
        _applyItemEffect(nftId, itemId);

        emit ShopItemPurchased(nftId, msg.sender, itemId);
    }

    function _applyItemEffect(uint256 nftId, uint256 itemId) internal {
        // Implement the logic to apply the item's effect to the NFT
        // This is a placeholder function and should be customized based on your requirements
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
