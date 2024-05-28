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
import "../PixotchiExtensionPermission.sol";


contract GardenLogic is
IGarden,
ReentrancyGuard,
    //ERC721AUpgradeable,
//PermissionsEnumerable,
Initializable,
PixotchiExtensionPermission
{
    using SafeTransferLib for address payable;
    using FixedPointMathLib for uint256;
    using SafeMathUpgradeable for uint256;
    /*///////////////////////////////////////////////////////////////
                        Constants / Immutables
    //////////////////////////////////////////////////////////////*/

    /// @dev Only lister role holders can create auctions, when auctions are restricted by lister address.
    //bytes32 private constant LISTER_ROLE = keccak256("LISTER_ROLE");
    /// @dev Only assets from NFT contracts with asset role can be auctioned, when auctions are restricted by asset address.
    //bytes32 private constant ASSET_ROLE = keccak256("ASSET_ROLE");

    /// @dev The max bps of the contract. So, 10_000 == 100 %
    //uint64 private constant MAX_BPS = 10_000;

    /// @dev The address of the native token wrapper contract.
    //address private immutable nativeTokenWrapper;

    /*///////////////////////////////////////////////////////////////
                              Modifiers
    //////////////////////////////////////////////////////////////*/

    modifier isApproved(uint256 id) {
        require(
            IERC721A(address(this)).ownerOf(id) == msg.sender,
            //ownerOf(id) == msg.sender,
            "Not approved"
        );

        _;
    }

    /*///////////////////////////////////////////////////////////////
                            Constructor logic
    //////////////////////////////////////////////////////////////*/

    //constructor(address _token, address _renderer) {
    function initializeGardenLogic() public initializer {
        //address _defaultAdmin = 0xC3f88d5925d9aa2ccc7b6cb65c5F8c7626591Daf;
        //_setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);

        uint256 etherConversion = 1 ether;
        uint256 pointsConversion = 1e12;
        uint256 timeConversion = 1 hours;

        createItem("Sunlight", 8 * etherConversion, 60 * pointsConversion, 0);
        createItem("Water", 6 * etherConversion, 0, 4 * timeConversion);
        createItem("Fertilizer", 20 * etherConversion, 150 * pointsConversion, 0);
        createItem("Pollinator", 10 * etherConversion, 0, 6 * timeConversion);
        createItem("Magic Soil", 25 * etherConversion, 350 * pointsConversion, 0);
        createItem("Dream Dew", 35 * etherConversion, 50 * pointsConversion, 12 * timeConversion);
    }


    function getAllGardenItem()
    public
    view

    returns (IGarden.FullItem[] memory)
    {
        GameStorage.Data storage s = _s();
        uint256 itemCount = s._itemIds;
        IGarden.FullItem[] memory items = new IGarden.FullItem[](itemCount);

        for (uint256 i = 0; i < itemCount; i++) {
            items[i] = IGarden.FullItem({
                id: i,
                name: s.itemName[i],
                price: s.itemPrice[i],
                points: s.itemPoints[i],
                timeExtension: s.itemTimeExtension[i]
            });
        }

        return items;
    }

    function buyAccessory(
        uint256 nftId,
        uint256 itemId
    ) external payable isApproved(nftId) nonReentrant {
        require(itemExists(itemId), "This item doesn't exist");
        require(IGame(address(this)).isPlantAlive(nftId), "plant dead"); //no revives

        uint256 amount = _s().itemPrice[itemId];

        // recalculate time until starving
        _s().plantTimeUntilStarving[nftId] += _s().itemTimeExtension[itemId];

        if (_s().plantScore[nftId] > 0) {
            _s().ethOwed[nftId] = IGame(address(this)).pendingEth(nftId);
        }

        if (!IGame(address(this)).isPlantAlive(nftId)) {
            _s().plantScore[nftId] = _s().itemPoints[itemId];
        } else {
            _s().plantScore[nftId] += _s().itemPoints[itemId];
        }

        _s().plantRewardDebt[nftId] = _s().plantScore[nftId].mulDivDown(
            _s().ethAccPerShare,
            _s().PRECISION
        );

        _s().totalScores += _s().itemPoints[itemId];

        //token.burnFrom(msg.sender, amount);
        _s().guardDisarmed = true;
        INFT(address(this)).tokenBurnAndRedistribute(msg.sender, amount);
        _s().guardDisarmed = false;

        emit ItemConsumed(nftId, msg.sender, itemId);
    }

    /*///////////////////////////////////////////////////////////////
                            View functions
    //////////////////////////////////////////////////////////////*/

    function itemExists(uint256 itemId) public view returns (bool) {
        if (bytes(_s().itemName[itemId]).length > 0) {
            return true;
        } else {
            return false;
        }
    }

    /// @dev Returns the storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }

    //    function authorizeAddress(address account, bool authorized) public onlyRole(DEFAULT_ADMIN_ROLE) {
    //        _s().IsAuthorized[account] = authorized;
    //    }

    //    function setConfig(/*uint256 _Price, uint256 _maxSupply,*/ bool _mintIsActive, uint256 _burnPercentage) public onlyRole(DEFAULT_ADMIN_ROLE) {
    //        require(_burnPercentage <= 100, "Burn percentage can't be more than 100");
    //        //_s().Mint_Price = _Price;
    //        //_s().maxSupply = _maxSupply;
    //        _s().mintIsActive = _mintIsActive;
    //        _s().burnPercentage = _burnPercentage;
    //    }
    //
    //    function setRenderer(address _renderer) external onlyRole(DEFAULT_ADMIN_ROLE) {
    //        _s().renderer = IRenderer(_renderer);
    //    }
    //
    //    function setRevShareWallet(address _revShareWallet) external onlyRole(DEFAULT_ADMIN_ROLE) {
    //        _s().revShareWallet = _revShareWallet;
    //    }
    //
    //    function setToken(address _token) external onlyRole(DEFAULT_ADMIN_ROLE) {
    //        _s().token = IToken(_token);
    //    }

    // add items/accessories
    function createItem(
        string memory name,
        uint256 price,
        uint256 points,
        uint256 timeExtension
    ) public onlyAdminRole {
        uint256 newItemId = _s()._itemIds;
        _s().itemName[newItemId] = name;
        _s().itemPrice[newItemId] = price;
        _s().itemPoints[newItemId] = points;
        _s().itemTimeExtension[newItemId] = timeExtension;

        _s()._itemIds++;

        emit ItemCreated(newItemId, name, price, points);
    }

    // New function to create multiple items
    function createItems(
        FullItem[] calldata items
    ) external onlyAdminRole {
        //we are ignoring the id in the struct and using the index of the array
        for (uint i = 0; i < items.length; i++) {
            createItem(
                items[i].name,
                items[i].price,
                items[i].points,
                items[i].timeExtension
            );
        }
    }

    function editItem(
        uint256 _id,
        uint256 _price,
        uint256 _points,
        string calldata _name,
        uint256 _timeExtension
    ) public onlyAdminRole {
        _s().itemPrice[_id] = _price;
        _s().itemPoints[_id] = _points;
        _s().itemName[_id] = _name;
        _s().itemTimeExtension[_id] = _timeExtension;
    }

    // New function to edit multiple items
    function editItems(
        FullItem[] calldata updates
    ) external onlyAdminRole {
        for (uint i = 0; i < updates.length; i++) {
            editItem(
                updates[i].id,
                updates[i].price,
                updates[i].points,
                updates[i].name,
                updates[i].timeExtension
            );
        }
    }

    //    function _msgData() internal view override(Permissions, Context) returns (bytes calldata) {
    //        return Context._msgData();
    //    }
    //
    //    function _msgSender() internal view override(Permissions, Context) returns (address sender) {
    //        return Context._msgSender();
    //    }
}
