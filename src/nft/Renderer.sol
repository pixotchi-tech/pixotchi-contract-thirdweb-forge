// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*

.-------. .-./`) _____     __   ,-----.  ,---------.   _______   .---.  .---..-./`)
\  _(`)_ \\ .-.')\   _\   /  /.'  .-,  '.\          \ /   __  \  |   |  |_ _|\ .-.')
| (_ o._)|/ `-' \.-./ ). /  '/ ,-.|  \ _ \`--.  ,---'| ,_/  \__) |   |  ( ' )/ `-' \
|  (_,_) / `-'`"`\ '_ .') .';  \  '_ /  | :  |   \ ,-./  )       |   '-(_{;}_)`-'`"`
|   '-.-'  .---.(_ (_) _) ' |  _`,/ \ _/  |  :_ _: \  '_ '`)     |      (_,_) .---.
|   |      |   |  /    \   \: (  '\_/ \   ;  (_I_)  > (_)  )  __ | _ _--.   | |   |
|   |      |   |  `-'`-'    \\ `"/  \  ) /  (_(=)_)(  .  .-'_/  )|( ' ) |   | |   |
/   )      |   | /  /   \    \'. \_/``".'    (_I_)  `-'`-'     / (_{;}_)|   | |   |
`---'      '---''--'     '----' '-----'      '---'    `._____.'  '(_,_) '---' '---'

https://t.me/Pixotchi
https://twitter.com/pixotchi
https://pixotchi.tech/
*/

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import"../IPixotchi.sol";

contract Renderer is IRenderer {

    //string private jsonStart = 'data:application/json;base64,';
    //string private jsonEnd = '"}';

    constructor() {
    }

    function prepareTokenURI(IGame.Plant calldata plant, string calldata ipfsHash, string calldata status, uint256 level) external pure returns (string memory)
    {

        //IGame.Status _status = IGame(address(this)).getStatus(plant.id);

        //string memory statusString = statusToString(_status); // Convert status enum to string

        //uint256 level = IGame(address(this)).level(plant.id);


//        string memory attributes = string(abi.encodePacked(
//            '{"name":"', plant.name,
//            '","attributes":[{"trait_type":"ID","value":"', Strings.toString(plant.id),
//            '"},{"trait_type":"Score","value":"', Strings.toString(plant.score),
//            //'"},{"trait_type":"Stars","value":"', Strings.toString(plant.stars),
//            '"},{"trait_type":"Strain","value":"', Strings.toString(plant.strain),
//            '"},{"trait_type":"Time Until Starving","value":"', Strings.toString(plant.timeUntilStarving),
//            //'"},{"trait_type":"Time Plant Born","value":"', Strings.toString(plant.timePlantBorn),
//            //'"},{"trait_type":"Last Attack Used","value":"', Strings.toString(plant.lastAttackUsed),
//            //'"},{"trait_type":"Last Attacked","value":"', Strings.toString(plant.lastAttacked),
//            //'"},{"trait_type":"Level","value":"', Strings.toString(level),
//            '"},{"trait_type":"Status","value":"', status,
//            '"}],"image": '
//        ));
        string memory part2 = string(abi.encodePacked(
            '"},{"trait_type":"Time Plant Born","value":"', Strings.toString(plant.timePlantBorn),
            '"},{"trait_type":"Last Attack Used","value":"', Strings.toString(plant.lastAttackUsed),
            '"},{"trait_type":"Last Attacked","value":"', Strings.toString(plant.lastAttacked),
            '"},{"trait_type":"Level","value":"', Strings.toString(level),
            '"},{"trait_type":"Status","value":"', status,
            '"}],"image": '
        ));


        string memory attributes = string(abi.encodePacked(
            '{"name":"', plant.name,
            '","attributes":[{"trait_type":"ID","value":"', Strings.toString(plant.id),
            '"},{"trait_type":"Score","value":"', Strings.toString(plant.score),
            '"},{"trait_type":"Stars","value":"', Strings.toString(plant.stars),
            '"},{"trait_type":"Strain","value":"', Strings.toString(plant.strain),
            '"},{"trait_type":"Time Until Starving","value":"', Strings.toString(plant.timeUntilStarving),
            part2
        ));

        return string(abi.encodePacked(
            //jsonStart,
        'data:application/json;base64,',
            Base64.encode(bytes(string(
                abi.encodePacked(
                    attributes,
                    getImageUri(level, ipfsHash)//,
                    //jsonEnd
                )
            )))
        ));
    }


    function getImageUri(uint256 _level, string calldata ipfsHash) public pure returns (string memory) {
        return append('ipfs://', ipfsHash, '/', string(abi.encodePacked(Strings.toString(_level), '.svg')), '"}');
    }
    function append(string memory a, string memory b, string memory c, string memory d, string memory e) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b, c, d, e));
    }


//    // Function to convert Status enum to string
//    function statusToString(IGame.Status status) public pure returns (string memory) {
//        if (status == IGame.Status.JOYFUL) {
//            return "JOYFUL";
//        } else if (status == IGame.Status.THIRSTY) {
//            return "THIRSTY";
//        } else if (status == IGame.Status.NEGLECTED) {
//            return "NEGLECTED";
//        } else if (status == IGame.Status.SICK) {
//            return "SICK";
//        } else if (status == IGame.Status.DEAD) {
//            return "DEAD";
//        } else if (status == IGame.Status.BURNED) {
//            return "BURNED";
//        }
//        return ""; // Default case, should not happen
//    }

}
