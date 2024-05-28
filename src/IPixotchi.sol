// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IConfig {

    // Admin functions
//    //function authorizeAddress(address account, bool authorized) external;
//
//    function setConfig(/*uint256 _Price, uint256 _maxSupply,*/ bool _mintIsActive, uint256 _burnPercentage) external;
//
//    function setRenderer(address _renderer) external;
//
//    function setRevShareWallet(address _wallet) external;
//
//    function setToken(address _token) external;
}

interface IShop {
    //function buyShopItem(uint256 nftId, uint256 itemId) external;

    //function shopItemExists(uint256 itemId) external view returns (bool);

//    function createShopItem(
//        string calldata name,
//        uint256 price,
//        uint256 _ExpireTime
//    ) external;

    //event ShopItemCreated(uint256 id, string name, uint256 price, uint256 ExpireTime);
    //event ItemCreated(uint256 id, string name, uint256 price, uint256 points);
    //event BoughtFromShop(uint256 nftId, address giver, uint256 shopItemId);

    struct ShopItem {
        uint256 id;
        string name;
        uint256 price;
        uint256 ExpireTime; //for example 3days timespan.
    }

    struct ShopItemOwned {
        uint256 id;
        string name;
        //uint256 price;
        uint256 EffectUntil; //in the future. per owner
    }

    function getAllShopItem() external pure returns(ShopItem[] memory);

    function getPurchasedShopItems(uint256 nftId) external view returns(ShopItemOwned[] memory);



}

interface IGarden {
    // Define a struct to hold plant information
    struct FullItem {
        uint256 id;
        string name;
        uint256 price;
        uint256 points;
        uint256 timeExtension;
    }


    event ItemConsumed(uint256 nftId, address giver, uint256 itemId);

    event ItemCreated(uint256 id, string name, uint256 price, uint256 points);

    function getAllGardenItem() external view returns(FullItem[] memory);

    //function createItem(string calldata _name, uint256 _price, uint256 _points, uint256 _timeExtension) external;

    //function editItem(uint256 _id, uint256 _price, uint256 _points, string calldata _name, uint256 _timeExtension) external;


}

interface INFT {
    function mint(uint256 strain) external;

    //function mintTo(uint256 strain, address to) external;

    function burn(uint256 id) external;

    event Mint(address to, uint256 strain, uint256 id);

    function tokenBurnAndRedistribute(address account, uint256 amount) external;

    function removeTokenIdFromOwner(uint32 tokenId, address owner) external returns (bool);

}

interface IRenderer {
    function prepareTokenURI(IGame.Plant calldata plant, string calldata ipfsHash, string calldata status, uint256 level) external view returns (string memory);
}

interface IGame {

    enum  Status {
        JOYFUL, //0
        THIRSTY, //1
        NEGLECTED, //2
        SICK, //3
        DEAD, //4,
        BURNED //5
    }

    struct Strain {
        uint256 id;
        uint256 mintPrice;
        uint256 totalSupply;
        uint256 totalMinted;
        uint256 maxSupply;
        string name;
        bool isActive;
        uint256 getStrainTotalLeft;
    }

    struct Plant {
        uint256 id;
        string name;
        uint256 timeUntilStarving;
        uint256 score;
        uint256 timePlantBorn;
        uint256 lastAttackUsed;
        uint256 lastAttacked;
        uint256 stars;
        uint256 strain;
    }


    event Killed(
        uint256 nftId,
        uint256 deadId,
        string loserName,
        uint256 reward,
        address killer,
        string winnerName
    );


    event Attack(
        uint256 attacker,
        uint256 winner,
        uint256 loser,
        uint256 scoresWon
    );
    event RedeemRewards(uint256 indexed id, uint256 reward);

    event Pass(uint256 from, uint256 to);

    //event Mint(uint256 id);

    event Played(uint256 indexed id, uint256 points, uint256 timeExtension);
    event PlayedV2(uint256 indexed id, int256 points, int256 timeExtension);

    // Player functions
    //function mint(uint256 strain) external;
    function attack(uint256 fromId, uint256 toId) external;

    function kill(uint256 _deadId, uint256 _tokenId) external;

    function setPlantName(uint256 _id, string calldata _name) external;

    function pass(uint256 from, uint256 to) external;



    function isPlantAlive(uint256 _nftId) external view returns (bool);

    function pendingEth(uint256 plantId) external view returns (uint256);

    function level(uint256 tokenId) external view returns (uint256);

    function getStatus(uint256 plant) external view returns (IGame.Status);

    function statusToString(IGame.Status status) external pure returns (string memory);

    function getAllStrainInfo() external view returns(Strain[] memory);





//function createItem(string calldata _name, uint256 _price, uint256 _points, uint256 _timeExtension) external;
    //function editItem(uint256 _id, uint256 _price, uint256 _points, string calldata _name, uint256 _timeExtension) external;

    // Events
    //event PlantCreated(uint256 indexed _plantId, address indexed _owner);
    //event AttackOccurred(uint256 indexed _plantId, address indexed _attacker);
    //event KillOccurred(uint256 indexed _plantId, address indexed _killer);
    // event ItemCreated(uint256 indexed _itemId, string _name, uint256 _price, uint256 _points);
}


