// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;

interface IGameLogic {

}

interface IPixotchiV1 {
    /*//////////////////////////////////////////////////////////////
                     events
//////////////////////////////////////////////////////////////*/

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
}


interface IGameStorage {


}
