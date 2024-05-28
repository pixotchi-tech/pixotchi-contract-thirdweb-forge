// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../game/GameStorage.sol";
import "../IPixotchi.sol";
import "../utils/FixedPointMathLib.sol";
//import "../utils/ERC2771ContextConsumer.sol";

import "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";
import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";

contract NFTLogic is
INFT,
ReentrancyGuard,
ERC721AUpgradeable//,
//PermissionsEnumerable//,
//ERC2771ContextConsumer
//Context
{
    using SafeTransferLib for address payable;
    using FixedPointMathLib for uint256;
    using SafeMathUpgradeable for uint256;
    /*///////////////////////////////////////////////////////////////
                        Constants / Immutables
    //////////////////////////////////////////////////////////////*/

    /*///////////////////////////////////////////////////////////////
                              Modifiers
    //////////////////////////////////////////////////////////////*/

//    modifier isApproved(uint256 id) {
//        require(
//            ownerOf(id) == msg.sender,
//            "Not approved"
//        );
//
//        _;
//    }

    /**
 * @dev Modifier to guard functions.
     *
     * This modifier only allows the function to be executed if the guard is disarmed.
     * The guard is disarmed if `_s().guardDisarmed` is true. After the function executes,
     * or if it fails before execution, `guardDisarmed` is set to false, preventing further
     * calls until it is explicitly disarmed again.
     *
     * This function is intended to protect public functions, ensuring that they can only
     * be accessed by other ERC-7504 extensions and by the router, but not by any other entity.
     *
     * Requirements:
     * - `_s().guardDisarmed` must be true.
     *
     * Emits no events.
     */
    modifier guard() {
        require(_s().guardDisarmed, "Guard is not disarmed");
        _s().guardDisarmed = false;
        _;
    }

    /*///////////////////////////////////////////////////////////////
                            Constructor logic
    //////////////////////////////////////////////////////////////*/

    //constructor(address _token, address _renderer) {
    function initializeNFTLogic() public reinitializer(3) {
        address _token = 0xa62b1E028E40c68ECD037239D7A115187b7Ead44;
        address _defaultAdmin = 0xC3f88d5925d9aa2ccc7b6cb65c5F8c7626591Daf;
        //address _renderer = 0x9D4F2b4D49A83A22F902629aD7d6Bd0329224A50;


        //_setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);

        __ERC721A_init("NAME", "SYMBOL");

        _s().token = IToken(_token);
        _s().mintIsActive = true;
        _s().revShareWallet = _defaultAdmin; //temporary wallet
        _s().burnPercentage = 1; // 0-100%



    }

    /*//////////////////////////////////////////////////////////////
                receive ether function, interface support
    //////////////////////////////////////////////////////////////*/

//    receive() external payable {
//        _s().ethAccPerShare += msg.value.mulDivDown(_s().PRECISION, _s().totalScores);
//    }

//    function supportsInterface(bytes4 interfaceId) public view override(ERC721Upgradeable)
//    returns (bool) {
//        return super.supportsInterface(interfaceId);
//    }

    /*///////////////////////////////////////////////////////////////
                    external write functions
    //////////////////////////////////////////////////////////////*/

    function mint(uint256 strain) external {
        _mintTo(strain, msg.sender);
    }

    /*//////////////////////////////////////////////////////////////
                    external guarded write functions
//////////////////////////////////////////////////////////////*/

    function tokenBurnAndRedistribute(address account, uint256 amount) external guard {
        _tokenBurnAndRedistribute(account, amount);
    }

    function removeTokenIdFromOwner(uint32 tokenId, address owner) external guard returns (bool) {
        return _removeTokenIdFromOwner(tokenId, owner);
    }

    function burn(uint256 tokenId) external guard {
        super._burn(tokenId);
    }

    /*/////////////////////////////////////////////////////////////
                        Game functions
    //////////////////////////////////////////////////////////////*/

    /*///////////////////////////////////////////////////////////////
                            View functions
    //////////////////////////////////////////////////////////////*/


    function tokenURI(uint256 id) public view override returns (string memory) {
        IGame.Plant memory plant = getPlantInfo(id);
        string memory ipfsHash = _s().strainIPFSHash[plant.strain];

        IGame.Status status = IGame(address(this)).getStatus(plant.id);
        string memory statusString = IGame(address(this)).statusToString(status); // Convert status enum to string
        //string memory statusString = statusToString(_status); // Convert status enum to string


        uint256 level = IGame(address(this)).level(plant.id);
        return IRenderer(address(this)).prepareTokenURI(plant, ipfsHash, statusString, level);
        //(IGame.Plant calldata plant, string calldata ipfsHash, string calldata status, uint256 level)
    }

    function getPlantInfo(uint256 id)
    public
    view
    returns (IGame.Plant memory)
    {
        //IGame.Plant memory plant _s().plants[id];

        return IGame.Plant({
            id: id,
            name: _s().plantName[id],
            timeUntilStarving: _s().plantTimeUntilStarving[id],
            score: _s().plantScore[id],
            timePlantBorn: _s().plantTimeBorn[id],
            lastAttackUsed: _s().plantLastAttackUsed[id],
            lastAttacked: _s().plantLastAttacked[id],
            stars: _s().plantStars[id],
            strain: _s().plantStrain[id]
        });
    }

        function getPlantsInfo(uint256[] memory _nftIds) public view returns (IGame.Plant[] memory) {
        IGame.Plant[] memory plants = new IGame.Plant[](_nftIds.length);
        for (uint256 i = 0; i < _nftIds.length; i++) {
            plants[i] = getPlantInfo(_nftIds[i]);
        }
        return plants;
    }

    function getPlantsByOwner(address _owner) public view returns (IGame.Plant[] memory) {
        uint32[] storage ids = _s().idsByOwner[_owner];
        IGame.Plant[] memory plants = new IGame.Plant[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {
            plants[i] = getPlantInfo(ids[i]);
        }
        return plants;
    }

    //function getPlantsInfo(uint256[] memory _nftIds) public view returns (IGame.Plant[] memory) {
    //function getPlantsByOwner(address _owner) public view returns (IGame.Plant[] memory) {


    /*///////////////////////////////////////////////////////////////
                            Internal functions
    //////////////////////////////////////////////////////////////*/

    function _addTokenIdToOwner(uint32 tokenId, address owner) internal {
        _s().ownerIndexById[tokenId] = uint32(_s().idsByOwner[owner].length);
        _s().idsByOwner[owner].push(tokenId);
    }

    function _mintTo(uint256 strain, address to) internal nonReentrant {
        require(_s().mintIsActive, "Mint is closed");
        require(_s().strainIsActive[strain], "Strain is not active");
        require(_s().strainTotalMinted[strain] < _s().strainMaxSupply[strain], "Strain supply exceeded");

        _tokenBurnAndRedistribute(to, _s().mintPriceByStrain[strain]);
        uint256 tokenId = _totalMinted();

        IGame.Plant memory plant = IGame.Plant({
            id: tokenId,
            name: "",
            timeUntilStarving: block.timestamp + 1 days,
            score: 0,
            timePlantBorn: block.timestamp,
            lastAttackUsed: 0,
            lastAttacked: 0,
            stars: 0,
            strain: strain
        });

        _createPlant(plant);

        _addTokenIdToOwner(uint32(tokenId), to);
        uint256 quantity = 1;
        _mint(to, quantity);
        emit Mint(to, strain, tokenId);

        _s().strainTotalMinted[strain]++;
    }


    function _createPlant(IGame.Plant memory plant) internal {
        _s().plantName[plant.id] = plant.name;
        _s().plantStrain[plant.id] = plant.strain;
        _s().plantTimeBorn[plant.id] = block.timestamp;
        _s().plantTimeUntilStarving[plant.id] = plant.timeUntilStarving;
        _s().plantScore[plant.id] = plant.score;
        _s().plantLastAttackUsed[plant.id] = plant.lastAttackUsed;
        _s().plantLastAttacked[plant.id] = plant.lastAttacked;
        _s().plantStars[plant.id] = plant.stars;
    }

    function _tokenBurnAndRedistribute(address account, uint256 amount) internal {
        uint256 _burnPercentage = _s().burnPercentage;

        // Calculate the burn amount based on the provided amount
        uint256 _burnAmount = amount.mulDivDown(_burnPercentage, 100);

        // Calculate the amount for revShareWallet
        uint256 _revShareAmount = amount.mulDivDown(100 - _burnPercentage, 100);

        // Burn the calculated amount of tokens
        if (_burnAmount > 0) {
            _s().token.transferFrom(account, address(0), _burnAmount);
        }

        // Transfer the calculated share of tokens to the revShareWallet
        if (_revShareAmount > 0) {
            _s().token.transferFrom(account, _s().revShareWallet, _revShareAmount);
        }
    }

    function _removeTokenIdFromOwner(uint32 tokenId, address owner) internal returns (bool) {
        uint32[] storage ids = _s().idsByOwner[owner];
        uint256 balance = ids.length;

        uint32 index = _s().ownerIndexById[tokenId];
        if (ids[index] != tokenId) {
            return false;
        }
        uint32 movingId = ids[index] = ids[balance - 1];
        _s().ownerIndexById[movingId] = index;
        ids.pop();

        return true;
    }

    function _beforeTokenTransfers(address from, address to, uint256 tokenId, uint256 batchSize) internal override(ERC721AUpgradeable) {
        ERC721AUpgradeable._beforeTokenTransfers(from, to, tokenId, batchSize);
        if (from == address(0)) {
        } else if (to == address(0)) {
        } else {
            _removeTokenIdFromOwner(uint32(tokenId), from);
            _addTokenIdToOwner(uint32(tokenId), to);
        }
    }

    // Override the _burn function to track burned plant IDs
    function _burn(uint256 tokenId) internal override {
        super._burn(tokenId);
        _s().burnedPlants[tokenId] = true; // Mark the plant ID as burned
    }

    /// @dev Returns the storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }

//    function _msgData() internal view override(ERC2771ContextConsumer, Context, Permissions) returns (bytes calldata) {
//        return ERC2771ContextConsumer._msgData();
//    }
//
//    function _msgSender() internal view override(ERC2771ContextConsumer, Context, Permissions) returns (address sender) {
//        return ERC2771ContextConsumer._msgSender();
//    }
        function _msgData() internal view override(Context/*, Permissions*/) returns (bytes calldata) {
        return Context._msgData();
    }

    function _msgSender() internal view override(Context/*, Permissions*/) returns (address sender) {
        return Context._msgSender();
    }


}
