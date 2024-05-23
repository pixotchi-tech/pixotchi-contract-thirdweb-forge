//// SPDX-License-Identifier: MIT
//pragma solidity 0.8.18;
//
///*
//
//.-------. .-./`) _____     __   ,-----.  ,---------.   _______   .---.  .---..-./`)
//\  _(`)_ \\ .-.')\   _\   /  /.'  .-,  '.\          \ /   __  \  |   |  |_ _|\ .-.')
//| (_ o._)|/ `-' \.-./ ). /  '/ ,-.|  \ _ \`--.  ,---'| ,_/  \__) |   |  ( ' )/ `-' \
//|  (_,_) / `-'`"`\ '_ .') .';  \  '_ /  | :  |   \ ,-./  )       |   '-(_{;}_)`-'`"`
//|   '-.-'  .---.(_ (_) _) ' |  _`,/ \ _/  |  :_ _: \  '_ '`)     |      (_,_) .---.
//|   |      |   |  /    \   \: (  '\_/ \   ;  (_I_)  > (_)  )  __ | _ _--.   | |   |
//|   |      |   |  `-'`-'    \\ `"/  \  ) /  (_(=)_)(  .  .-'_/  )|( ' ) |   | |   |
///   )      |   | /  /   \    \'. \_/``".'    (_I_)  `-'`-'     / (_{;}_)|   | |   |
//`---'      '---''--'     '----' '-----'      '---'    `._____.'  '(_,_) '---' '---'
//
//https://t.me/Pixotchi
//https://twitter.com/pixotchi
//https://pixotchi.tech/
//*/
//
//// Importing necessary components from OpenZeppelin's upgradeable contracts library.
//import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
//import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
//
//// Interface for the Pixotchi NFT that this game contract will interact with.
//interface IPixotchiNFTforBoxGame {
//  // Function to update points and rewards for an NFT.
//  function updatePointsAndRewards(uint256 _nftId, uint256 _points, uint256 _timeExtension) external;
//  // Function to get the owner of a specific NFT.
//  function ownerOf(uint256 tokenId) external view returns (address owner);
//  // check that Plant didn't starve
//  function isPlantAlive(uint256 _nftId) external view returns (bool);
//}
//
//// Main game contract, inheriting from OpenZeppelin's upgradeable contracts.
//contract BoxGameV2 is Initializable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
//
//  // State variables for the game.
//  IPixotchiNFTforBoxGame public nftContract; // Reference to the NFT contract.
//  uint256 public coolDownTime; // Cooldown time between plays for each NFT.
//  uint256 public nftContractRewardDecimals; // Decimals for reward calculation.
//  mapping(uint256 => uint256) public lastPlayed; // Tracks last played time for each NFT.
//  uint256[] public pointRewards; // Array storing point rewards.
//  uint256[] public timeRewards; // Array storing time rewards.
//
//  // Function to initialize the contract. Only callable once.
//  function initialize(address _nftContract) initializer public {
//    nftContract = IPixotchiNFTforBoxGame(_nftContract); // Set the NFT contract.
//    coolDownTime = 24 hours; // Default cooldown time.
//    nftContractRewardDecimals = 1e12; // Set the reward decimals.
//    __Ownable_init(); // Initialize the Ownable contract.
//    __ReentrancyGuard_init(); // Initialize the ReentrancyGuard contract.
//    pointRewards = [0, 25 * 1e12, 50 * 1e12, 75 * 1e12, 100 * 1e12]; // Initialize point rewards.
//    timeRewards = [0, 3 hours , 5 hours, 7 hours, 9 hours]; // Initialize time rewards.
//  }
//
//  // Function to allow users to play the game with a specific NFT.
//  function play(uint256 nftID, uint256 seed) public nonReentrant returns (uint256 points, uint256 timeExtension)  {
//    // Ensure the caller is the owner of the NFT and meets other requirements.
//    require(nftContract.ownerOf(nftID) == msg.sender, "Not the owner of nft");
//    require(seed > 0 && seed < 10, "Seed should be between 1-9");
//    require(getCoolDownTimePerNFT(nftID) == 0, "Cool down time has not passed yet");
//    require(nftContract.isPlantAlive(nftID), "Plant is dead");
//
//    // Generate random indices for points and time rewards.
//    uint256 pointsIndex = random(seed, 0, pointRewards.length - 1);
//    points = pointRewards[pointsIndex];
//    uint256 timeIndex = random2(seed, 0, timeRewards.length - 1);
//    timeExtension = timeRewards[timeIndex];
//
//    // Record the current time as the last played time for this NFT.
//    lastPlayed[nftID] = block.timestamp;
//
//    // Update the NFT with new points and time extension.
//    nftContract.updatePointsAndRewards(nftID, points, timeExtension);
//
//    // Return the points and time extension.
//    return (points, timeExtension);
//  }
//
//  // Function to get the remaining cooldown time for an NFT.
//  function getCoolDownTimePerNFT(uint256 nftID) public view returns (uint256) {
//    uint256 lastPlayedTime = lastPlayed[nftID];
//    // Return 0 if the NFT has never been played.
//    if (lastPlayedTime == 0) {
//      return 0;
//    }
//    // Check if the current time is less than the last played time (edge case).
//    if (block.timestamp < lastPlayedTime) {
//      return coolDownTime;
//    }
//    // Calculate the time passed since last played.
//    uint256 timePassed = block.timestamp - lastPlayedTime;
//    // Return 0 if the cooldown has passed, otherwise return remaining time.
//    if (timePassed >= coolDownTime) {
//      return 0;
//    }
//    return coolDownTime - timePassed;
//  }
//
//  // Function for the contract owner to set the global cooldown time.
//  function setGlobalCoolDownTime(uint256 _coolDownTime) public onlyOwner {
//    coolDownTime = _coolDownTime;
//  }
//
//  //set pointRewards
//  function setPointRewards(uint256[] memory _pointRewards) public onlyOwner {
//    pointRewards = _pointRewards;
//  }
//
//  //set timeRewards
//  function setTimeRewards(uint256[] memory _timeRewards) public onlyOwner {
//    timeRewards = _timeRewards;
//  }
//
//  //  function to generate a pseudo-random number based on several blockchain parameters.
//  function random(uint256 seed, uint256 min, uint256 max) public view returns (uint) {
//    uint randomHash = uint(keccak256(abi.encodePacked(blockhash(block.number-1), block.prevrandao, seed, block.number)));
//    return min + (randomHash % (max - min + 1));
//  }
//
//  // Secondary  function for random number generation.
//  function random2(uint256 seed, uint256 min, uint256 max) public view returns (uint) {
//    uint randomHash = uint(keccak256(abi.encodePacked(seed, block.prevrandao, block.timestamp, msg.sender)));
//    return min + (randomHash % (max - min + 1));
//  }
//
//  //uint256
//  function random3(uint256 seed, uint256 min, uint256 max) public view returns (uint256) {
//    uint256 randomHash = uint256(keccak256(abi.encodePacked(blockhash(block.number-1), block.prevrandao, seed, block.number)));
//    return min + (randomHash % (max - min + 1));
//  }
//
//  //uint256
//
//  function random4(uint256 seed, uint256 min, uint256 max) public view returns (uint256) {
//    uint256 randomHash = uint256(keccak256(abi.encodePacked(seed, block.prevrandao, block.timestamp, msg.sender)));
//    return min + (randomHash % (max - min + 1));
//  }
//
//  //no input
//  function random5() public view returns (uint256) {
//    uint256 randomHash = uint256(keccak256(abi.encodePacked(
//      tx.origin,
//      blockhash(block.number - 1),
//      block.timestamp
//    )));
//    return randomHash;
//  }
//
//  function random6(uint256 min, uint256 max) public view returns (uint256) {
//    uint256 randomHash = random5();
//    uint256 returnValue = min + (randomHash % (max - min + 1));
//    return returnValue;
//  }
//
//}
