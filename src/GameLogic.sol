// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;

/// @author thirdweb

import "./GameStorage.sol";
import "./IPixotchi.sol";

import "./FixedPointMathLib.sol";

import  "../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
//import "../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
//import {ReentrancyGuardUpgradeableWithInit} from "../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/mocks/WithInit.sol";
//import "../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";
import "../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";
//import  "../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/token/ERC721/ERC721Upgradeable.sol";

// ====== External imports ======
//import "@openzeppelin/contracts/utils/Context.sol";
//import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
//import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
//import "../../../eip/interface/IERC721.sol";
//import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "@openzeppelin/contracts/interfaces/IERC2981.sol";

// ====== Internal imports ======

//import "../../../extension/interface/IPlatformFee.sol";
//import "../../../extension/upgradeable/ERC2771ContextConsumer.sol";
//import "../../../extension/upgradeable/ReentrancyGuard.sol";
//import "../../../extension/upgradeable/PermissionsEnumerable.sol";
//import { RoyaltyPaymentsLogic } from "../../../extension/upgradeable/RoyaltyPayments.sol";
//import { CurrencyTransferLib } from "../../../lib/CurrencyTransferLib.sol";

import "../lib/contracts/lib/solady/src/utils/SafeTransferLib.sol";
import "../lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol";
//lib/contracts/lib/openzeppelin-contracts-upgradeable/contracts/utils/math/SafeMathUpgradeable.sol

/**
 * @author  thirdweb.com
 */
contract GameLogic is IGameLogic, ReentrancyGuard, ERC721AUpgradeable/*, ReentrancyGuard*/ {

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

//    modifier onlyListerRole() {
//        require(Permissions(address(this)).hasRoleWithSwitch(LISTER_ROLE, _msgSender()), "!LISTER_ROLE");
//        _;
//    }
//
//    modifier onlyAssetRole(address _asset) {
//        require(Permissions(address(this)).hasRoleWithSwitch(ASSET_ROLE, _asset), "!ASSET_ROLE");
//        _;
//    }
//
//    /// @dev Checks whether caller is a auction creator.
//    modifier onlyAuctionCreator(uint256 _auctionId) {
//        require(
//            _englishAuctionsStorage().auctions[_auctionId].auctionCreator == _msgSender(),
//            "Marketplace: not auction creator."
//        );
//        _;
//    }
//
//    /// @dev Checks whether an auction exists.
//    modifier onlyExistingAuction(uint256 _auctionId) {
//        require(
//            _englishAuctionsStorage().auctions[_auctionId].status == IEnglishAuctions.Status.CREATED,
//            "Marketplace: invalid auction."
//        );
//        _;
//    }

    /*///////////////////////////////////////////////////////////////
                            Constructor logic
    //////////////////////////////////////////////////////////////*/

    constructor(address _token, address _renderer) {

        __ERC721A_init("NAME","SYMBOL");

        //nativeTokenWrapper = _nativeTokenWrapper;
        //__ERC721_init("Pixotchi", "PIX");
        //__Ownable_init();
        //__ReentrancyGuard_init();
        _s().token = IToken(_token);
        _s().renderer = IRenderer(_renderer);
        _s().la = 2;
        _s().lb = 2;
        _s().totalScores = 0;
        _s().Mint_Price = 100 * 1e18;
        _s().maxSupply = 20_000;
        _s().mintIsActive = true;
        _s().revShareWallet = msg.sender; //temporary wallet
        _s().burnPercentage = 0; // 0-100%
    }

    /*//////////////////////////////////////////////////////////////
                receive ether function, interface support
    //////////////////////////////////////////////////////////////*/

    receive() external payable {
        _s().ethAccPerShare += msg.value.mulDivDown(_s().PRECISION, _s().totalScores);
    }

//    function supportsInterface(bytes4 interfaceId) public view override(ERC721Upgradeable)
//    returns (bool) {
//        return super.supportsInterface(interfaceId);
//    }


    /*///////////////////////////////////////////////////////////////
                            External functions
    //////////////////////////////////////////////////////////////*/

    function mint() public nonReentrant {
        require(_s().mintIsActive, "Mint is closed");
        require(_s()._tokenIds < _s().maxSupply, "Over the limit");
        tokenBurnAndRedistribute(msg.sender, _s().Mint_Price);

        _s().plants[_s()._tokenIds] = IPixotchiV1.Plant({
            name: "",
            timeUntilStarving: block.timestamp + 1 days,
            score: 0,
            timePlantBorn: block.timestamp,
            lastAttackUsed: 0,
            lastAttacked: 0,
            stars: 0
        });

        addTokenIdToOwner(uint32(_s()._tokenIds), msg.sender);
        _mint(msg.sender, _s()._tokenIds);
        emit IPixotchiV1.Mint(_s()._tokenIds);
        _s()._tokenIds++;
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

    function removeTokenIdFromOwner(uint32 tokenId, address owner) internal returns(bool) {
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

        _s().totalScores -= _s().plants[id].score;
        _s().plants[id].score = 0;
        _s().ethOwed[id] = 0;
        _s(). plantRewardDebt[id] = 0;

        payable(_to).safeTransferETH(pending);

        emit IPixotchiV1.RedeemRewards(id, pending);
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
            _s().plants[plantId].score.mulDivDown(_ethAccPerShare, _s().PRECISION) <
            _s().plantRewardDebt[plantId]
        ) {
            return _s().ethOwed[plantId];
        } else {
            return
                (_s().plants[plantId].score.mulDivDown(_ethAccPerShare, _s().PRECISION))
                .sub(_s().plantRewardDebt[plantId])
                .add(_s().ethOwed[plantId]);
        }
    }

//    /// @notice Auction ERC721 or ERC1155 NFTs.
//    function createAuction(
//        AuctionParameters calldata _params
//    ) external onlyListerRole onlyAssetRole(_params.assetContract) nonReentrant returns (uint256 auctionId) {
//        auctionId = _getNextAuctionId();
//        address auctionCreator = _msgSender();
//        TokenType tokenType = _getTokenType(_params.assetContract);
//
//        _validateNewAuction(_params, tokenType);
//
//        Auction memory auction = Auction({
//            auctionId: auctionId,
//            auctionCreator: auctionCreator,
//            assetContract: _params.assetContract,
//            tokenId: _params.tokenId,
//            quantity: _params.quantity,
//            currency: _params.currency,
//            minimumBidAmount: _params.minimumBidAmount,
//            buyoutBidAmount: _params.buyoutBidAmount,
//            timeBufferInSeconds: _params.timeBufferInSeconds,
//            bidBufferBps: _params.bidBufferBps,
//            startTimestamp: _params.startTimestamp,
//            endTimestamp: _params.endTimestamp,
//            tokenType: tokenType,
//            status: IEnglishAuctions.Status.CREATED
//        });
//
//        _englishAuctionsStorage().auctions[auctionId] = auction;
//
//        _transferAuctionTokens(auctionCreator, address(this), auction);
//
//        emit NewAuction(auctionCreator, auctionId, _params.assetContract, auction);
//    }
//
//    function bidInAuction(
//        uint256 _auctionId,
//        uint256 _bidAmount
//    ) external payable nonReentrant onlyExistingAuction(_auctionId) {
//        Auction memory _targetAuction = _englishAuctionsStorage().auctions[_auctionId];
//
//        require(
//            _targetAuction.endTimestamp > block.timestamp && _targetAuction.startTimestamp <= block.timestamp,
//            "Marketplace: inactive auction."
//        );
//        require(_bidAmount != 0, "Marketplace: Bidding with zero amount.");
//        require(
//            _targetAuction.currency == CurrencyTransferLib.NATIVE_TOKEN || msg.value == 0,
//            "Marketplace: invalid native tokens sent."
//        );
//        require(
//            _bidAmount <= _targetAuction.buyoutBidAmount || _targetAuction.buyoutBidAmount == 0,
//            "Marketplace: Bidding above buyout price."
//        );
//
//        Bid memory newBid = Bid({ auctionId: _auctionId, bidder: _msgSender(), bidAmount: _bidAmount });
//
//        _handleBid(_targetAuction, newBid);
//    }
//
//    function collectAuctionPayout(uint256 _auctionId) external nonReentrant {
//        require(
//            !_englishAuctionsStorage().payoutStatus[_auctionId].paidOutBidAmount,
//            "Marketplace: payout already completed."
//        );
//        _englishAuctionsStorage().payoutStatus[_auctionId].paidOutBidAmount = true;
//
//        Auction memory _targetAuction = _englishAuctionsStorage().auctions[_auctionId];
//        Bid memory _winningBid = _englishAuctionsStorage().winningBid[_auctionId];
//
//        require(_targetAuction.status != IEnglishAuctions.Status.CANCELLED, "Marketplace: invalid auction.");
//        require(_targetAuction.endTimestamp <= block.timestamp, "Marketplace: auction still active.");
//        require(_winningBid.bidder != address(0), "Marketplace: no bids were made.");
//
//        _closeAuctionForAuctionCreator(_targetAuction, _winningBid);
//
//        if (_targetAuction.status != IEnglishAuctions.Status.COMPLETED) {
//            _englishAuctionsStorage().auctions[_auctionId].status = IEnglishAuctions.Status.COMPLETED;
//        }
//    }
//
//    function collectAuctionTokens(uint256 _auctionId) external nonReentrant {
//        Auction memory _targetAuction = _englishAuctionsStorage().auctions[_auctionId];
//        Bid memory _winningBid = _englishAuctionsStorage().winningBid[_auctionId];
//
//        require(_targetAuction.status != IEnglishAuctions.Status.CANCELLED, "Marketplace: invalid auction.");
//        require(_targetAuction.endTimestamp <= block.timestamp, "Marketplace: auction still active.");
//        require(_winningBid.bidder != address(0), "Marketplace: no bids were made.");
//
//        _closeAuctionForBidder(_targetAuction, _winningBid);
//
//        if (_targetAuction.status != IEnglishAuctions.Status.COMPLETED) {
//            _englishAuctionsStorage().auctions[_auctionId].status = IEnglishAuctions.Status.COMPLETED;
//        }
//    }
//
//    /// @dev Cancels an auction.
//    function cancelAuction(
//        uint256 _auctionId
//    ) external onlyExistingAuction(_auctionId) onlyAuctionCreator(_auctionId) nonReentrant {
//        Auction memory _targetAuction = _englishAuctionsStorage().auctions[_auctionId];
//        Bid memory _winningBid = _englishAuctionsStorage().winningBid[_auctionId];
//
//        require(_winningBid.bidder == address(0), "Marketplace: bids already made.");
//
//        _englishAuctionsStorage().auctions[_auctionId].status = IEnglishAuctions.Status.CANCELLED;
//
//        _transferAuctionTokens(address(this), _targetAuction.auctionCreator, _targetAuction);
//
//        emit CancelledAuction(_targetAuction.auctionCreator, _auctionId);
//    }

    /*///////////////////////////////////////////////////////////////
                            View functions
    //////////////////////////////////////////////////////////////*/

//    function isNewWinningBid(
//        uint256 _auctionId,
//        uint256 _bidAmount
//    ) external view onlyExistingAuction(_auctionId) returns (bool) {
//        Auction memory _targetAuction = _englishAuctionsStorage().auctions[_auctionId];
//        Bid memory _currentWinningBid = _englishAuctionsStorage().winningBid[_auctionId];
//
//        return
//            _isNewWinningBid(
//                _targetAuction.minimumBidAmount,
//                _currentWinningBid.bidAmount,
//                _bidAmount,
//                _targetAuction.bidBufferBps
//            );
//    }
//
//    function totalAuctions() external view returns (uint256) {
//        return _englishAuctionsStorage().totalAuctions;
//    }
//
//    function getAuction(uint256 _auctionId) external view returns (Auction memory _auction) {
//        _auction = _englishAuctionsStorage().auctions[_auctionId];
//    }
//
//    function getAllAuctions(uint256 _startId, uint256 _endId) external view returns (Auction[] memory _allAuctions) {
//        require(_startId <= _endId && _endId < _englishAuctionsStorage().totalAuctions, "invalid range");
//
//        _allAuctions = new Auction[](_endId - _startId + 1);
//
//        for (uint256 i = _startId; i <= _endId; i += 1) {
//            _allAuctions[i - _startId] = _englishAuctionsStorage().auctions[i];
//        }
//    }
//
//    function getAllValidAuctions(
//        uint256 _startId,
//        uint256 _endId
//    ) external view returns (Auction[] memory _validAuctions) {
//        require(_startId <= _endId && _endId < _englishAuctionsStorage().totalAuctions, "invalid range");
//
//        Auction[] memory _auctions = new Auction[](_endId - _startId + 1);
//        uint256 _auctionCount;
//
//        for (uint256 i = _startId; i <= _endId; i += 1) {
//            uint256 j = i - _startId;
//            _auctions[j] = _englishAuctionsStorage().auctions[i];
//            if (
//                _auctions[j].startTimestamp <= block.timestamp &&
//                _auctions[j].endTimestamp > block.timestamp &&
//                _auctions[j].status == IEnglishAuctions.Status.CREATED &&
//                _auctions[j].assetContract != address(0)
//            ) {
//                _auctionCount += 1;
//            }
//        }
//
//        _validAuctions = new Auction[](_auctionCount);
//        uint256 index = 0;
//        uint256 count = _auctions.length;
//        for (uint256 i = 0; i < count; i += 1) {
//            if (
//                _auctions[i].startTimestamp <= block.timestamp &&
//                _auctions[i].endTimestamp > block.timestamp &&
//                _auctions[i].status == IEnglishAuctions.Status.CREATED &&
//                _auctions[i].assetContract != address(0)
//            ) {
//                _validAuctions[index++] = _auctions[i];
//            }
//        }
//    }
//
//    function getWinningBid(
//        uint256 _auctionId
//    ) external view returns (address _bidder, address _currency, uint256 _bidAmount) {
//        Auction memory _targetAuction = _englishAuctionsStorage().auctions[_auctionId];
//        Bid memory _currentWinningBid = _englishAuctionsStorage().winningBid[_auctionId];
//
//        _bidder = _currentWinningBid.bidder;
//        _currency = _targetAuction.currency;
//        _bidAmount = _currentWinningBid.bidAmount;
//    }
//
//    function isAuctionExpired(uint256 _auctionId) external view onlyExistingAuction(_auctionId) returns (bool) {
//        return _englishAuctionsStorage().auctions[_auctionId].endTimestamp >= block.timestamp;
//    }

    /*///////////////////////////////////////////////////////////////
                            Internal functions
    //////////////////////////////////////////////////////////////*/

//    /// @dev Returns the next auction Id.
//    function _getNextAuctionId() internal returns (uint256 id) {
//        id = _englishAuctionsStorage().totalAuctions;
//        _englishAuctionsStorage().totalAuctions += 1;
//    }
//
//    /// @dev Returns the interface supported by a contract.
//    function _getTokenType(address _assetContract) internal view returns (TokenType tokenType) {
//        if (IERC165(_assetContract).supportsInterface(type(IERC1155).interfaceId)) {
//            tokenType = TokenType.ERC1155;
//        } else if (IERC165(_assetContract).supportsInterface(type(IERC721).interfaceId)) {
//            tokenType = TokenType.ERC721;
//        } else {
//            revert("Marketplace: auctioned token must be ERC1155 or ERC721.");
//        }
//    }
//
//    /// @dev Checks whether the auction creator owns and has approved marketplace to transfer auctioned tokens.
//    function _validateNewAuction(AuctionParameters memory _params, TokenType _tokenType) internal view {
//        require(_params.quantity > 0, "Marketplace: auctioning zero quantity.");
//        require(_params.quantity == 1 || _tokenType == TokenType.ERC1155, "Marketplace: auctioning invalid quantity.");
//        require(_params.timeBufferInSeconds > 0, "Marketplace: no time-buffer.");
//        require(_params.bidBufferBps > 0, "Marketplace: no bid-buffer.");
//        require(
//            _params.startTimestamp + 60 minutes >= block.timestamp && _params.startTimestamp < _params.endTimestamp,
//            "Marketplace: invalid timestamps."
//        );
//        require(
//            _params.buyoutBidAmount == 0 || _params.buyoutBidAmount >= _params.minimumBidAmount,
//            "Marketplace: invalid bid amounts."
//        );
//    }
//
//    /// @dev Processes an incoming bid in an auction.
//    function _handleBid(Auction memory _targetAuction, Bid memory _incomingBid) internal {
//        Bid memory currentWinningBid = _englishAuctionsStorage().winningBid[_targetAuction.auctionId];
//        uint256 currentBidAmount = currentWinningBid.bidAmount;
//        uint256 incomingBidAmount = _incomingBid.bidAmount;
//        address _nativeTokenWrapper = nativeTokenWrapper;
//
//        // Close auction and execute sale if there's a buyout price and incoming bid amount is buyout price.
//        if (_targetAuction.buyoutBidAmount > 0 && incomingBidAmount >= _targetAuction.buyoutBidAmount) {
//            incomingBidAmount = _targetAuction.buyoutBidAmount;
//            _incomingBid.bidAmount = _targetAuction.buyoutBidAmount;
//
//            _closeAuctionForBidder(_targetAuction, _incomingBid);
//        } else {
//            /**
//             *      If there's an exisitng winning bid, incoming bid amount must be bid buffer % greater.
//             *      Else, bid amount must be at least as great as minimum bid amount
//             */
//            require(
//                _isNewWinningBid(
//                    _targetAuction.minimumBidAmount,
//                    currentBidAmount,
//                    incomingBidAmount,
//                    _targetAuction.bidBufferBps
//                ),
//                "Marketplace: not winning bid."
//            );
//
//            // Update the winning bid and auction's end time before external contract calls.
//            _englishAuctionsStorage().winningBid[_targetAuction.auctionId] = _incomingBid;
//
//            if (_targetAuction.endTimestamp - block.timestamp <= _targetAuction.timeBufferInSeconds) {
//                _targetAuction.endTimestamp += _targetAuction.timeBufferInSeconds;
//                _englishAuctionsStorage().auctions[_targetAuction.auctionId] = _targetAuction;
//            }
//        }
//
//        // Payout previous highest bid.
//        if (currentWinningBid.bidder != address(0) && currentBidAmount > 0) {
//            CurrencyTransferLib.transferCurrencyWithWrapper(
//                _targetAuction.currency,
//                address(this),
//                currentWinningBid.bidder,
//                currentBidAmount,
//                _nativeTokenWrapper
//            );
//        }
//
//        // Collect incoming bid
//        CurrencyTransferLib.transferCurrencyWithWrapper(
//            _targetAuction.currency,
//            _incomingBid.bidder,
//            address(this),
//            incomingBidAmount,
//            _nativeTokenWrapper
//        );
//
//        emit NewBid(
//            _targetAuction.auctionId,
//            _incomingBid.bidder,
//            _targetAuction.assetContract,
//            _incomingBid.bidAmount,
//            _targetAuction
//        );
//    }
//
//    /// @dev Checks whether an incoming bid is the new current highest bid.
//    function _isNewWinningBid(
//        uint256 _minimumBidAmount,
//        uint256 _currentWinningBidAmount,
//        uint256 _incomingBidAmount,
//        uint256 _bidBufferBps
//    ) internal pure returns (bool isValidNewBid) {
//        if (_currentWinningBidAmount == 0) {
//            isValidNewBid = _incomingBidAmount >= _minimumBidAmount;
//        } else {
//            isValidNewBid = (_incomingBidAmount > _currentWinningBidAmount &&
//                ((_incomingBidAmount - _currentWinningBidAmount) * MAX_BPS) / _currentWinningBidAmount >=
//                _bidBufferBps);
//        }
//    }
//
//    /// @dev Closes an auction for the winning bidder; distributes auction items to the winning bidder.
//    function _closeAuctionForBidder(Auction memory _targetAuction, Bid memory _winningBid) internal {
//        require(
//            !_englishAuctionsStorage().payoutStatus[_targetAuction.auctionId].paidOutAuctionTokens,
//            "Marketplace: payout already completed."
//        );
//        _englishAuctionsStorage().payoutStatus[_targetAuction.auctionId].paidOutAuctionTokens = true;
//
//        _targetAuction.endTimestamp = uint64(block.timestamp);
//
//        _englishAuctionsStorage().winningBid[_targetAuction.auctionId] = _winningBid;
//        _englishAuctionsStorage().auctions[_targetAuction.auctionId] = _targetAuction;
//
//        _transferAuctionTokens(address(this), _winningBid.bidder, _targetAuction);
//
//        emit AuctionClosed(
//            _targetAuction.auctionId,
//            _targetAuction.assetContract,
//            _msgSender(),
//            _targetAuction.tokenId,
//            _targetAuction.auctionCreator,
//            _winningBid.bidder
//        );
//    }
//
//    /// @dev Closes an auction for an auction creator; distributes winning bid amount to auction creator.
//    function _closeAuctionForAuctionCreator(Auction memory _targetAuction, Bid memory _winningBid) internal {
//        uint256 payoutAmount = _winningBid.bidAmount;
//        _payout(address(this), _targetAuction.auctionCreator, _targetAuction.currency, payoutAmount, _targetAuction);
//
//        emit AuctionClosed(
//            _targetAuction.auctionId,
//            _targetAuction.assetContract,
//            _msgSender(),
//            _targetAuction.tokenId,
//            _targetAuction.auctionCreator,
//            _winningBid.bidder
//        );
//    }
//
//    /// @dev Transfers tokens for auction.
//    function _transferAuctionTokens(address _from, address _to, Auction memory _auction) internal {
//        if (_auction.tokenType == TokenType.ERC1155) {
//            IERC1155(_auction.assetContract).safeTransferFrom(_from, _to, _auction.tokenId, _auction.quantity, "");
//        } else if (_auction.tokenType == TokenType.ERC721) {
//            IERC721(_auction.assetContract).safeTransferFrom(_from, _to, _auction.tokenId, "");
//        }
//    }
//
//    /// @dev Pays out stakeholders in auction.
//    function _payout(
//        address _payer,
//        address _payee,
//        address _currencyToUse,
//        uint256 _totalPayoutAmount,
//        Auction memory _targetAuction
//    ) internal {
//        address _nativeTokenWrapper = nativeTokenWrapper;
//        uint256 amountRemaining;
//
//        // Payout platform fee
//        {
//            (address platformFeeRecipient, uint16 platformFeeBps) = IPlatformFee(address(this)).getPlatformFeeInfo();
//            uint256 platformFeeCut = (_totalPayoutAmount * platformFeeBps) / MAX_BPS;
//
//            // Transfer platform fee
//            CurrencyTransferLib.transferCurrencyWithWrapper(
//                _currencyToUse,
//                _payer,
//                platformFeeRecipient,
//                platformFeeCut,
//                _nativeTokenWrapper
//            );
//
//            amountRemaining = _totalPayoutAmount - platformFeeCut;
//        }
//
//        // Payout royalties
//        {
//            // Get royalty recipients and amounts
//            (address payable[] memory recipients, uint256[] memory amounts) = RoyaltyPaymentsLogic(address(this))
//                .getRoyalty(_targetAuction.assetContract, _targetAuction.tokenId, _totalPayoutAmount);
//
//            uint256 royaltyRecipientCount = recipients.length;
//
//            if (royaltyRecipientCount != 0) {
//                uint256 royaltyCut;
//                address royaltyRecipient;
//
//                for (uint256 i = 0; i < royaltyRecipientCount; ) {
//                    royaltyRecipient = recipients[i];
//                    royaltyCut = amounts[i];
//
//                    // Check payout amount remaining is enough to cover royalty payment
//                    require(amountRemaining >= royaltyCut, "fees exceed the price");
//
//                    // Transfer royalty
//                    CurrencyTransferLib.transferCurrencyWithWrapper(
//                        _currencyToUse,
//                        _payer,
//                        royaltyRecipient,
//                        royaltyCut,
//                        _nativeTokenWrapper
//                    );
//
//                    unchecked {
//                        amountRemaining -= royaltyCut;
//                        ++i;
//                    }
//                }
//            }
//        }
//
//        // Distribute price to token owner
//        CurrencyTransferLib.transferCurrencyWithWrapper(
//            _currencyToUse,
//            _payer,
//            _payee,
//            amountRemaining,
//            _nativeTokenWrapper
//        );
//    }

    /// @dev Returns the EnglishAuctions storage.
    function _s() internal pure returns (GameStorage.Data storage data) {
        data = GameStorage.data();
    }
}
