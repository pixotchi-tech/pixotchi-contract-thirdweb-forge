// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface IGameLogic {

    struct Strain {
        uint256 id;
        uint256 mintPrice;
        uint256 totalSupply;
        uint256 totalMinted;
        uint256 maxSupply;
        string name;
        bool isActive;
    }

    struct Plant {
        string name;
        uint256 timeUntilStarving;
        uint256 score;
        uint256 timePlantBorn;
        uint256 lastAttackUsed;
        uint256 lastAttacked;
        uint256 stars;
        uint256 strain;
    }

    // Define a struct to hold plant information
    struct FullItem {
        uint256 id;
        string name;
        uint256 price;
        uint256 points;
        uint256 timeExtension;
    }


    event ItemConsumed(uint256 nftId, address giver, uint256 itemId);

    event Killed(
        uint256 nftId,
        uint256 deadId,
        string loserName,
        uint256 reward,
        address killer,
        string winnerName
    );

    event ItemCreated(uint256 id, string name, uint256 price, uint256 points);

    event Attack(
        uint256 attacker,
        uint256 winner,
        uint256 loser,
        uint256 scoresWon
    );
    event RedeemRewards(uint256 indexed id, uint256 reward);

    event Pass(uint256 from, uint256 to);

    event Mint(uint256 id);

    event Played(uint256 indexed id, uint256 points, uint256 timeExtension);
    event PlayedV2(uint256 indexed id, int256 points, int256 timeExtension);


    // Player functions
    function mint(uint256 strain) external;
    function attack(uint256 fromId, uint256 toId) external;
    function kill(uint256 _deadId, uint256 _tokenId) external;
    function setPlantName(uint256 _id, string calldata _name) external;
    function pass(uint256 from, uint256 to) external;

    // Admin functions
    function authorizeAddress(address account, bool authorized) external;
    function setConfig(/*uint256 _Price, uint256 _maxSupply,*/ bool _mintIsActive, uint256 _burnPercentage) external;
    function setRenderer(address _renderer) external;
    function setRevShareWallet(address _wallet) external;
    function setToken(address _token) external;
    function createItem(string calldata _name, uint256 _price, uint256 _points, uint256 _timeExtension) external;
    function editItem(uint256 _id, uint256 _price, uint256 _points, string calldata _name, uint256 _timeExtension) external;

    // Events
    //event PlantCreated(uint256 indexed _plantId, address indexed _owner);
    //event AttackOccurred(uint256 indexed _plantId, address indexed _attacker);
    //event KillOccurred(uint256 indexed _plantId, address indexed _killer);
   // event ItemCreated(uint256 indexed _itemId, string _name, uint256 _price, uint256 _points);
}


