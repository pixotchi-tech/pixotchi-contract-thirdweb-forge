//// SPDX-License-Identifier: MIT
//pragma solidity ^0.8.20;
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
//@audit https://blocksafu.com/
//*/
//
//// Importing necessary components from OpenZeppelin's upgradeable contracts library.
//import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
//import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
//
//// Interface for the Pixotchi NFT that this game contract will interact with.
//interface IPixotchiNFTforBoxGame {
//    enum  Status {
//        JOYFUL, //0
//        THIRSTY, //1
//        NEGLECTED, //2
//        SICK, //3
//        DEAD, //4,
//        BURNED //5
//    }
//
//    struct Plant {
//        uint256 id;
//        string name;
//        Status status;
//        uint256 score;
//        uint256 level;
//        uint256 timeUntilStarving;
//        uint256 lastAttacked;
//        uint256 lastAttackUsed;
//        address owner;
//        uint256 rewards;
//        uint256 stars;
//    }
//    // Function to update points and rewards for an NFT.
//    //function updatePointsAndRewards(uint256 _nftId, uint256 _points, uint256 _timeExtension) external;
//    // Function to get the owner of a specific NFT.
//    function ownerOf(uint256 tokenId) external view returns (address owner);
//    // check that Plant didn't starve
//    function isPlantAlive(uint256 _nftId) external view returns (bool);
//
//    function getPlantInfo(uint256 _nftId) external view returns (Plant memory);
//
//    // Declaration for updatePointsAndRewardsV2 function
//    function updatePointsAndRewardsV2(uint256 _nftId, int256 _pointsAdjustment, int256 _timeAdjustment) external;
//}
//
//// Main game contract, inheriting from OpenZeppelin's upgradeable contracts.
//contract SpinGame is Initializable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
//
//    // State variables for the game.
//    IPixotchiNFTforBoxGame public nftContract; // Reference to the NFT contract.
//    uint256 public coolDownTime; // Cooldown time between plays for each NFT.
//    uint256 public nftContractRewardDecimals; // Decimals for reward calculation.
//    mapping(uint256 => uint256) public lastPlayed; // Tracks last played time for each NFT.
//    //uint256[] public pointRewards; // Array storing point rewards.
//    //uint256[] public timeRewards; // Array storing time rewards.
//
//    struct Reward {
//        int256 points; // Can be negative for deductions.
//        int256 timeAdjustment; // Can be negative for reductions. Represented in seconds.
//        bool isPercentage; // True if the adjustments are percentage-based.
//    }
//
//    event SpinPlayed(uint256 indexed nftID, int256 pointsAdjustment, int256 timeAdjustment);
//    event Rewarded(int256 points, int256 timeAdjustment, bool isPercentage);
//
//
//    Reward[] public rewards; // Array storing all possible rewards.
//    // Function to initialize the contract. Only callable once.
//    function initialize(address _nftContract) initializer public {
//        nftContract = IPixotchiNFTforBoxGame(_nftContract); // Set the NFT contract.
//        coolDownTime = 24 hours; // Default cooldown time.
//        nftContractRewardDecimals = 1e12; // Set the reward decimals.
//        __Ownable_init(); // Initialize the Ownable contract.
//        __ReentrancyGuard_init(); // Initialize the ReentrancyGuard contract.
//        //pointRewards = [0 * 1e12,0 * 1e12,0 * 1e12,0 * 1e12,0 * 1e12,0]; // Initialize point rewselectedRewardards.
//        //timeRewards = [0, 3 hours , 5 hours, 7 hours, 9 hours]; // Initialize time rewards.
//        rewards.push(Reward(0, 6 hours, false)); // +6H TOD
//        rewards.push(Reward(0, 12 hours, false)); // +12H TOD
//        rewards.push(Reward(150 * 1e12, 0, false)); // +150 Points
//        rewards.push(Reward(0, - 15, true)); // -15% TOD
//        rewards.push(Reward(- 10, 0, true)); // -10% Points
//        rewards.push(Reward(0, 0, false)); // Nothing
//
//
//    }
//
//    function getRewards() external view returns (Reward[] memory) {
//        return rewards;
//    }
//
//
//
////  // Function to allow users to play the game with a specific NFT.
////  function play(uint256 nftID, uint256 seed) public nonReentrant returns (uint256 points, uint256 timeExtension)  {
////    // Ensure the caller is the owner of the NFT and meets other requirements.
////    require(nftContract.ownerOf(nftID) == msg.sender, "Not the owner of nft");
////    require(seed > 0 && seed < 10, "Seed should be between 1-9");
////    require(getCoolDownTimePerNFT(nftID) == 0, "Cool down time has not passed yet");
////    require(nftContract.isPlantAlive(nftID), "Plant is dead");
////
////    // Generate random indices for points and time rewards.
////    uint256 pointsIndex = random(seed, 0, pointRewards.length - 1);
////    points = pointRewards[pointsIndex];
////    uint256 timeIndex = random2(seed, 0, timeRewards.length - 1);
////    timeExtension = timeRewards[timeIndex];
////
////    // Record the current time as the last played time for this NFT.
////    lastPlayed[nftID] = block.timestamp;
////
////    // Update the NFT with new points and time extension.
////    nftContract.updatePointsAndRewards(nftID, points, timeExtension);
////
////    // Return the points and time extension.
////    return (points, timeExtension);
////  }
//
//    function play(uint256 nftID, uint256 seed) public nonReentrant returns (int256 pointsAdjustment, int256 timeAdjustment) {
//        // Ensure the caller is the owner of the NFT and meets other requirements.
//        require(nftContract.ownerOf(nftID) == msg.sender, "Not the owner of nft");
//        //require(seed > 0 && seed < 10, "Seed should be between 1-9");
//        require(getCoolDownTimePerNFT(nftID) == 0, "Cool down time has not passed yet");
//        require(nftContract.isPlantAlive(nftID), "Plant is dead");
//
//      //Reward memory selectedReward = getRandomWithRetries(seed, 0, (rewards.length - 1));
//      uint256 selector = random(seed, 0, (rewards.length - 1));
//        emit RandomSuccess(selector);
//      Reward memory selectedReward = rewards[selector];
//      //Reward memory selectedReward = getRandomWithRetries(seed, 0, (rewards.length - 1));
//
//        emit Rewarded(selectedReward.points, selectedReward.timeAdjustment, selectedReward.isPercentage);
//
//        // Fetch the current state of the plant.
//        IPixotchiNFTforBoxGame.Plant memory plant = nftContract.getPlantInfo(nftID);
//
//        // Calculate adjustments based on the selected reward.
//        if (selectedReward.isPercentage) {
//            if (selectedReward.points != 0) {
//                pointsAdjustment = int256(plant.score) * selectedReward.points / 100;
//            }
//            if (selectedReward.timeAdjustment != 0) {
//                uint256 currentTimeUntilStarving = plant.timeUntilStarving - block.timestamp; // Calculate current TOD
//                timeAdjustment = int256(currentTimeUntilStarving) * selectedReward.timeAdjustment / 100; // Apply percentage adjustment
//                // Adjust the timeUntilStarving to reflect the percentage change and add back the current timestamp to set the new absolute timeUntilStarving.
//                plant.timeUntilStarving = uint256(int256(currentTimeUntilStarving) + timeAdjustment) + block.timestamp;
//            }
//        } else {
//            pointsAdjustment = selectedReward.points;
//            timeAdjustment = selectedReward.timeAdjustment;
//        }
//
//        // Apply adjustments to the plant.
//        lastPlayed[nftID] = block.timestamp;
//        emit SpinPlayed(nftID, pointsAdjustment, timeAdjustment);
//        nftContract.updatePointsAndRewardsV2(nftID, pointsAdjustment, timeAdjustment);
//
//        return (pointsAdjustment, timeAdjustment);
//    }
//
//    // Function to get the remaining cooldown time for an NFT.
//    function getCoolDownTimePerNFT(uint256 nftID) public view returns (uint256) {
//        uint256 lastPlayedTime = lastPlayed[nftID];
//        // Return 0 if the NFT has never been played.
//        if (lastPlayedTime == 0) {
//            return 0;
//        }
//        // Check if the current time is less than the last played time (edge case).
//        if (block.timestamp < lastPlayedTime) {
//            return coolDownTime;
//        }
//        // Calculate the time passed since last played.
//        uint256 timePassed = block.timestamp - lastPlayedTime;
//        // Return 0 if the cooldown has passed, otherwise return remaining time.
//        if (timePassed >= coolDownTime) {
//            return 0;
//        }
//        return coolDownTime - timePassed;
//    }
//
//    // Function for the contract owner to set the global cooldown time.
//    function setGlobalCoolDownTime(uint256 _coolDownTime) public onlyOwner {
//        coolDownTime = _coolDownTime;
//    }
//
//
//    // Function to set new rewards. Only callable by the contract owner.
//    function setRewards(Reward[] memory newRewards) public onlyOwner {
//        delete rewards; // Clear the current rewards array.
//        for (uint i = 0; i < newRewards.length; i++) {
//            rewards.push(newRewards[i]); // Add new rewards to the array.
//        }
//    }
//
//// Function to get the length of the rewards array.
//    function getRewardsLength() public view returns (uint) {
//        return rewards.length;
//    }
//
//    event RandomSuccess(uint result);
//
//
//    //pseudo rnd generator
////    function random(uint256 seed, uint256 min, uint256 max) public view returns (uint) {
////        uint randomHash = uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.prevrandao, seed)));
////        uint range = max - min + 1;
////        uint unbiasedMax = ~uint(0) - (~uint(0) % range);
////        while (randomHash > unbiasedMax) {
////            randomHash = uint(keccak256(abi.encodePacked(randomHash)));
////        }
////
////        uint rnd = min + (randomHash % range);
////        return rnd;
////    }
//    //pseudo rnd generator. ignores the seed
//    function random(uint256 seed, uint256 min, uint256 max) public view returns (uint) {
//        // Combine block-level entropy with the sender's address
//        uint randomHash = uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.prevrandao, msg.sender)));
//
//        // Define the range of the random numbers
//        uint range = max - min + 1;
//
//        // Calculate an unbiased upper limit
//        uint unbiasedMax = ~uint(0) - (~uint(0) % range);
//
//        // Ensure randomHash is within the unbiased range
//        while (randomHash > unbiasedMax) {
//            randomHash = uint(keccak256(abi.encodePacked(randomHash)));
//        }
//
//        // Calculate the final random number within the specified range
//        return min + (randomHash % range);
//    }
//
//
//
//
//}
