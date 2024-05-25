// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

// ====== Internal imports ======
import "./GameStorage.sol";
import "../IPixotchi.sol";

// ====== External imports ======
import "../utils/FixedPointMathLib.sol";
import "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";
import "../../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
import "../../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";


contract GameLogic is
IGameLogic,
ReentrancyGuard,
ERC721AUpgradeable,
PermissionsEnumerable//,
    //Initializable
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
            ownerOf(id) == msg.sender,
            "Not approved"
        );

        _;
    }

    /*///////////////////////////////////////////////////////////////
                            Constructor logic
    //////////////////////////////////////////////////////////////*/

    //constructor(address _token, address _renderer) {
    function initialize() public initializer {
        address _token = 0xc64F740D216B6ec49e435a8a08132529788e8DD0;
        address _renderer = 0x9D4F2b4D49A83A22F902629aD7d6Bd0329224A50;

        address _defaultAdmin = 0xC3f88d5925d9aa2ccc7b6cb65c5F8c7626591Daf;

        _setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);

        __ERC721A_init("NAME", "SYMBOL");

        //nativeTokenWrapper = _nativeTokenWrapper;
        //__ERC721_init("Pixotchi", "PIX");
        //__Ownable_init();
        //__ReentrancyGuard_init();
        _s().token = IToken(_token);
        _s().renderer = IRenderer(_renderer);
        _s().la = 2;
        _s().lb = 2;
        _s().totalScores = 0;
        //_s().Mint_Price = 100 * 1e18;
        // _s().maxSupply = 20_000;
        _s().mintIsActive = true;
        _s().revShareWallet = msg.sender; //temporary wallet
        _s().burnPercentage = 0; // 0-100%
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
                            External functions
    //////////////////////////////////////////////////////////////*/

    function mint(uint256 strain) external  {
        mintTo(strain, msg.sender);
    }


    function mintTo(uint256 strain, address _to) public nonReentrant {
        require(_s().mintIsActive, "Mint is closed");
        require(_s().strainIsActive[strain], "Strain is not active");
        require(_s().strainTotalMinted[strain] < _s().strainMaxSupply[strain], "Strain supply exceeded");



        tokenBurnAndRedistribute(msg.sender, _s().mintPriceByStrain[strain]);

        uint256 _tokenId = _totalMinted();

        //GameStorage.createPlant(owner, name, strain, timeUntilStarving, score, lastAttackUsed, lastAttacked, stars);

        IGameLogic.Plant memory _plant = Plant({
            name: "",
            timeUntilStarving: block.timestamp + 1 days,
            score: 0,
            timePlantBorn: block.timestamp,
            lastAttackUsed: 0,
            lastAttacked: 0,
            stars: 0,
            strain: strain
        });

        GameStorage.createPlant(_plant, _tokenId);

        addTokenIdToOwner(uint32(_tokenId), msg.sender);
        uint256 _quantity = 1;
        _mint(_to, _quantity);
        emit Mint(_tokenId);

        _s().strainTotalMinted[strain]++;
        //_s()._tokenIds++;
    }

    /*//////////////////////////////////////////////////////////////
                    internal functions
//////////////////////////////////////////////////////////////*/

    function tokenBurnAndRedistribute(address account, uint256 amount) internal {
        uint256 _burnPercentage = _s().burnPercentage;  // Assume burnPercentage is accessible here

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


    function addTokenIdToOwner(uint32 tokenId, address owner) internal {
        _s().ownerIndexById[tokenId] = uint32(_s().idsByOwner[owner].length);
        _s().idsByOwner[owner].push(tokenId);
    }

    function removeTokenIdFromOwner(uint32 tokenId, address owner) internal returns (bool) {
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
            removeTokenIdFromOwner(uint32(tokenId), from);
            addTokenIdToOwner(uint32(tokenId), to);
        }
    }


    function _redeem(uint256 id, address _to) internal {
        uint256 pending = pendingEth(id);

        GameStorage.Data storage s = _s();
        s.totalScores -= s.plantScore[id];
        s.plantScore[id] = 0;
        s.ethOwed[id] = 0;
        s.plantRewardDebt[id] = 0;

        payable(_to).safeTransferETH(pending);

        emit RedeemRewards(id, pending);
    }

    // Override the _burn function to track burned plant IDs
    function _burn(uint256 tokenId) internal override {
        super._burn(tokenId);
        _s().burnedPlants[tokenId] = true; // Mark the plant ID as burned
    }

    function pendingEth(uint256 plantId) public view returns (uint256) {
        uint256 _ethAccPerShare = _s().ethAccPerShare;

        //plantRewardDebt can sometimes be bigger by 1 wei do to several mulDivDowns so we do extra checks
        if (
            _s().plantScore[plantId].mulDivDown(_ethAccPerShare, _s().PRECISION) <
            _s().plantRewardDebt[plantId]
        ) {
            return _s().ethOwed[plantId];
        } else {
            return
                (_s().plantScore[plantId].mulDivDown(_ethAccPerShare, _s().PRECISION))
                .sub(_s().plantRewardDebt[plantId])
                .add(_s().ethOwed[plantId]);
        }
    }
    /*/////////////////////////////////////////////////////////////
                        Game functions
    //////////////////////////////////////////////////////////////*/

    function buyAccessory(
        uint256 nftId,
        uint256 itemId
    ) external payable isApproved(nftId) nonReentrant {
        require(itemExists(itemId), "This item doesn't exist");
        require(isPlantAlive(nftId), "plant dead"); //no revives

        uint256 amount = _s().itemPrice[itemId];

        // recalculate time until starving
        _s().plantTimeUntilStarving[nftId] += _s().itemTimeExtension[itemId];

        if (_s().plantScore[nftId] > 0) {
            _s().ethOwed[nftId] = pendingEth(nftId);
        }

        if (!isPlantAlive(nftId)) {
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
        tokenBurnAndRedistribute(msg.sender, amount);

        emit ItemConsumed(nftId, msg.sender, itemId);
    }

    function attack(uint256 fromId, uint256 toId) external isApproved(fromId) nonReentrant {
        require(fromId != toId, "Can't hurt yourself");
        require(isPlantAlive(fromId), "your plant is dead");
        require(isPlantAlive(toId), "plant dead");

        (uint256 pct, uint256 odds, bool canAttack) = onAttack(
            fromId,
            toId
        );

        if (!canAttack) {
            return;
        }

        _s().plantLastAttackUsed[fromId] = block.timestamp;
        _s().plantLastAttacked[toId] = block.timestamp;

        uint256 loser;
        uint256 winner;

        uint256 _random = random(fromId + toId);

        if (_random > odds) {
            loser = fromId;
            winner = toId;
        } else {
            loser = toId;
            winner = fromId;
        }

        uint256 feePercentage = _s().PRECISION.mulDivDown(pct, 1000); // 0.5 pct
        uint256 prizeScore = _s().plantScore[loser].mulDivDown(
            feePercentage,
            _s().PRECISION
        );

        uint256 prizeDebt = _s().plantRewardDebt[loser].mulDivDown(
            feePercentage,
            _s().PRECISION
        );

        _s().plantScore[loser] -= prizeScore;
        _s().plantRewardDebt[loser] -= prizeDebt;

        _s().plantScore[winner] += prizeScore;
        _s().plantRewardDebt[winner] += prizeDebt;

        emit Attack(fromId, winner, loser, prizeScore);
    }

    // kill and burn plants and get in game stars.
    function kill(
        uint256 _deadId,
        uint256 _tokenId
    ) external isApproved(_tokenId) nonReentrant {
        require(
            !isPlantAlive(_deadId),
            "The plant has to be dead to claim its points"
        );

        if (_s().hasTheDiamond == _deadId) {
            _s().hasTheDiamond = _tokenId;
        }

        address ownerOfDead = ownerOf(_deadId);

        removeTokenIdFromOwner(uint32(_deadId), ownerOfDead);

        _burn(_deadId);
        _s().plantStars[_tokenId] += 1;
        // redeem for dead plant
        _redeem(_deadId, ownerOfDead);

        emit Killed(
            _tokenId,
            _deadId,
            _s().plantName[_deadId],
            1,
            msg.sender,
            _s().plantName[_tokenId]
        );
    }

    function setPlantName(
        uint256 _id,
        string memory _name
    ) external isApproved(_id) {
        _s().plantName[_id] = _name;
    }

    // just side quest for later to add to ui, one thing in the game that can be passed to other players
    function pass(uint256 from, uint256 to) external isApproved(from) nonReentrant {
        require(_s().hasTheDiamond == from, "you don't have it");
        require(ownerOf(to) != address(0x0), "don't burn it");

        _s().hasTheDiamond = to;

        emit Pass(from, to);
    }

    // for updating from future contracts
    function updatePointsAndRewards(uint256 _nftId, uint256 _points, uint256 _timeExtension) external {
        require(_s().IsAuthorized[msg.sender], "Not Authorized");

        if (_timeExtension != 0)
            _s().plantTimeUntilStarving[_nftId] += _timeExtension;

        if (_s().plantScore[_nftId] > 0) {
            _s().ethOwed[_nftId] = pendingEth(_nftId);
        }

        _s().plantScore[_nftId] += _points;

        _s().plantRewardDebt[_nftId] = _s().plantScore[_nftId].mulDivDown(
            _s().ethAccPerShare,
            _s().PRECISION
        );

        _s().totalScores += _points;

        emit Played(_nftId, _points, _timeExtension);
    }

    function updatePointsAndRewardsV2(uint256 _nftId, int256 _points, int256 _timeExtension) external {
        require(_s().IsAuthorized[msg.sender], "Not Authorized");

        // Handling time extension adjustments
        if (_timeExtension != 0) {
            if (_timeExtension > 0 || uint256(- _timeExtension) <= _s().plantTimeUntilStarving[_nftId]) {
                // Safe to adjust time, whether adding or subtracting
                _s().plantTimeUntilStarving[_nftId] = uint256(int256(_s().plantTimeUntilStarving[_nftId]) + _timeExtension);
            } else {
                // Prevent underflow if trying to subtract more than the current value
                _s().plantTimeUntilStarving[_nftId] = 0;
            }
        }

        // Handling point adjustments
        if (_points != 0) {
            if (_points > 0 || uint256(- _points) <= _s().plantScore[_nftId]) {
                // Safe to adjust points, whether adding or subtracting
                _s().plantScore[_nftId] = uint256(int256(_s().plantScore[_nftId]) + _points);
            } else {
                // Prevent underflow if trying to subtract more than the current score
                _s().plantScore[_nftId] = 0;
            }

            // Adjust pending ETH, only if plantScore is positive
            if (_s().plantScore[_nftId] > 0) {
                _s().ethOwed[_nftId] = pendingEth(_nftId);
            }

            // Recalculate reward debt, assuming plantScore did not underflow
            _s().plantRewardDebt[_nftId] = _s().plantScore[_nftId].mulDivDown(_s().ethAccPerShare, _s().PRECISION);
        }

        // Adjust total scores accordingly, checking for underflow and overflow
        if (_points > 0) {
            _s().totalScores += uint256(_points);
        } else if (_points < 0) { // Check if points are negative to avoid unnecessary operations when _points are 0
            uint256 absPoints = uint256(- _points);
            if (absPoints > 0) { // Proceed only if absPoints is greater than 0
                if (absPoints <= _s().totalScores) {
                    _s().totalScores -= absPoints;
                } else {
                    // Handle the case where totalScores cannot absorb the subtraction, e.g., set to 0 or revert
                    _s().totalScores = 0; // or revert with an error message
                }
            }
            // If absPoints is 0, no changes are made to totalScores
        }
        // No else block needed for _points == 0 as no changes are required in that scenario

        emit PlayedV2(_nftId, _points, _timeExtension);
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

    // check that Plant didn't starve
    function isPlantAlive(uint256 _nftId) public view returns (bool) {
        uint256 _timeUntilStarving = _s().plantTimeUntilStarving[_nftId];
        if (_timeUntilStarving != 0 && _timeUntilStarving >= block.timestamp) {
            return true;
        } else {
            return false;
        }
    }

    // Function to handle an attack
    function onAttack(
        uint256 fromId, // ID of the attacker
        uint256 toId // ID of the one being attacked
    ) public view returns (uint256 pct, uint256 odds, bool canAttack) {
        // Ensure the attacker can only attack once every 15 minutes
        require(
            block.timestamp >= _s().plantLastAttackUsed[fromId] + 15 minutes ||
            _s().plantLastAttackUsed[fromId] == 0,
            "You have one attack every 15 mins"
        );
        // Ensure the one being attacked can only be attacked once every hour
        require(
            block.timestamp > _s().plantLastAttacked[toId] + 1 hours,
            "can be attacked once every hour"
        );

        // Ensure the attacker can only attack plants above their level
        require(
            level(fromId) < level(toId),
            "Only attack plants above your level"
        );

        pct = 5; // Set the percentage to 0.5%
        odds = 40; // Set the odds for the attacker as lower level to 40%
        canAttack = true; // Set canAttack to true
    }

    function level(uint256 tokenId) public view returns (uint256) {
        // This is the formula L(x) = 2 * sqrt(x * 2)
        uint256 _score = _s().plantScore[tokenId] / 1e12;
        _score = _score / 100;
        if (_score == 0) {
            return 1;
        }
        uint256 _level = _sqrtu(_score * _s().la);
        return (_level * _s().lb);
    }

    /*///////////////////////////////////////////////////////////////
                            Internal functions
    //////////////////////////////////////////////////////////////*/

    /**
 * Calculate sqrt (x) rounding down, where x is unsigned 256-bit integer
 * number.
 *
 * @param x unsigned 256-bit integer number
     * @return unsigned 128-bit integer number
     */
    function _sqrtu(uint256 x) private pure returns (uint128) {
        if (x == 0) return 0;
        else {
            uint256 xx = x;
            uint256 r = 1;
            if (xx >= 0x100000000000000000000000000000000) {
                xx >>= 128;
                r <<= 64;
            }
            if (xx >= 0x10000000000000000) {
                xx >>= 64;
                r <<= 32;
            }
            if (xx >= 0x100000000) {
                xx >>= 32;
                r <<= 16;
            }
            if (xx >= 0x10000) {
                xx >>= 16;
                r <<= 8;
            }
            if (xx >= 0x100) {
                xx >>= 8;
                r <<= 4;
            }
            if (xx >= 0x10) {
                xx >>= 4;
                r <<= 2;
            }
            if (xx >= 0x8) {
                r <<= 1;
            }
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1; // Seven iterations should be enough
            uint256 r1 = x / r;
            return uint128(r < r1 ? r : r1);
        }
    }

    // ok for the use case, game.
    function random(uint256 seed) private view returns (uint) {
        uint hashNumber = uint(
            keccak256(
                abi.encodePacked(
                    seed,
                    block.prevrandao,
                    block.timestamp,
                    msg.sender
                )
            )
        );
        return hashNumber % 100;
    }

    /// @dev Returns the storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }

    function authorizeAddress(address account, bool authorized) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().IsAuthorized[account] = authorized;
    }

    function setConfig(/*uint256 _Price, uint256 _maxSupply,*/ bool _mintIsActive, uint256 _burnPercentage) public onlyRole(DEFAULT_ADMIN_ROLE) {
        require(_burnPercentage <= 100, "Burn percentage can't be more than 100");
        //_s().Mint_Price = _Price;
        //_s().maxSupply = _maxSupply;
        _s().mintIsActive = _mintIsActive;
        _s().burnPercentage = _burnPercentage;
    }

    function setRenderer(address _renderer) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().renderer = IRenderer(_renderer);
    }

    function setRevShareWallet(address _revShareWallet) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().revShareWallet = _revShareWallet;
    }

    function setToken(address _token) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().token = IToken(_token);
    }

    // add items/accessories
    function createItem(
        string calldata name,
        uint256 price,
        uint256 points,
        uint256 timeExtension
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        uint256 newItemId = _s()._itemIds;
        _s().itemName[newItemId] = name;
        _s().itemPrice[newItemId] = price;
        _s().itemPoints[newItemId] = points;
        _s().itemTimeExtension[newItemId] = timeExtension;

        _s()._itemIds++;

        emit ItemCreated(newItemId, name, price, points);
    }

    // New function to create multiple items
    function createItems(FullItem[] calldata items) external onlyRole(DEFAULT_ADMIN_ROLE) {
        //we are ignoring the id in the struct and using the index of the array
        for (uint i = 0; i < items.length; i++) {
            createItem(items[i].name, items[i].price, items[i].points, items[i].timeExtension);
        }
    }


    function editItem(
        uint256 _id,
        uint256 _price,
        uint256 _points,
        string calldata _name,
        uint256 _timeExtension
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _s().itemPrice[_id] = _price;
        _s().itemPoints[_id] = _points;
        _s().itemName[_id] = _name;
        _s().itemTimeExtension[_id] = _timeExtension;
    }

    // New function to edit multiple items
    function editItems(FullItem[] calldata updates) external onlyRole(DEFAULT_ADMIN_ROLE) {
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

    function _msgData() internal view override(Permissions, Context) returns (bytes calldata) {
        return Context._msgData();
    }

    function _msgSender() internal view override(Permissions, Context) returns (address sender) {
        return Context._msgSender();
    }

}
