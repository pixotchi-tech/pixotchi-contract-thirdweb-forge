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
    ) public  {
        // Dummy implementation
    }

    function shopItemExists(uint256 itemId) public view  returns (bool) {
        // Dummy implementation
        return false;
    }

    function getAllShopItem() public pure  returns (ShopItem[] memory) {
        // Dummy implementation
        return new ShopItem[](0);
    }

    function getPurchasedShopItems(uint256 nftId) public view  returns (ShopItemOwned[] memory) {
        // Dummy implementation
        return new ShopItemOwned[](0);
    }




//    function createShopItem(
//        string calldata name,
//        uint256 price,
//        uint256 _ExpireTime
//    ) public /*onlyOwner*/ {
//
////        ShopItem storage _shopItem = shopItems[_shopItemIds];
////        _shopItem.id = _shopItemIds;
////        _shopItem.name = name;
////        _shopItem.price = price;
////        _shopItem.ExpireTime = _ExpireTime;
////        _shopItemIds++;
//        _s().shopItemName[]
//        _s().totalShopItems++;
//        emit ShopItemCreated(newItemId, name, price, _ExpireTime);
//    }


//    function shopItemExists(uint256 itemId) public view returns (bool) {
//        if (bytes(shopItems[itemId].name).length > 0) {
//            return true;
//        } else {
//            return false;
//        }
//    }
//
//    /// @dev Returns the storage.
//    function _s() internal pure returns (GameStorage.Data storage data) {
//        data = GameStorage.data();
//    }



}
