// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;



interface IGameStorage {



    struct Plant {
        string name;
        uint256 timeUntilStarving;
        uint256 score;
        uint256 timePlantBorn;
        uint256 lastAttackUsed;
        uint256 lastAttacked;
        uint256 stars;
    }

    // Define a struct to hold plant information
    struct FullItem {
        uint256 id;
        string name;
        uint256 price;
        uint256 points;
        uint256 timeExtension;
    }
}
