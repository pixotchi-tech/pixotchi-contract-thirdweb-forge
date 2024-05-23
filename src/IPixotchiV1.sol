pragma solidity ^0.8.0;

interface IPixotchiV1 {
    // Player functions
    function mint() external;
    function attack(uint256 _plantId) external;
    function kill(uint256 _plantId) external;
    function setPlantName(uint256 _plantId, string calldata _name) external;
    function pass(uint256 _itemId, address _to) external;

    // Admin functions
    function authorizeAddress(address _address) external;
    function setConfig(uint256 _price, uint256 _maxSupply, bool _mintingStatus) external;
    function setRenderer(address _renderer) external;
    function setRevShareWallet(address _wallet) external;
    function setToken(address _token) external;
    function createItem(string calldata _name, uint256 _price, uint256 _points, uint256 _timeExtension) external;
    function editItem(uint256 _id, uint256 _price, uint256 _points, string calldata _name, uint256 _timeExtension) external;

    // Events
    event PlantCreated(uint256 indexed _plantId, address indexed _owner);
    event AttackOccurred(uint256 indexed _plantId, address indexed _attacker);
    event KillOccurred(uint256 indexed _plantId, address indexed _killer);
    event ItemCreated(uint256 indexed _itemId, string _name, uint256 _price, uint256 _points);
}
