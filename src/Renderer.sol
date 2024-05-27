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

import {IRenderer} from "./IRenderer.sol";
//import {ISVG} from "./ISVG.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "./utils/Constants.sol";


contract Renderer is IRenderer {

    //ISVG public svgRenderer;

    string private jsonStart = 'data:application/json;base64,';
    string private jsonEnd = '"}';

    string public baseURI = 'ipfs://bafybeihh455vcsu5oiorg37x7v5tj2lkpgplsw373f7q6ttungmnfa3tgu/';

    constructor(/*address _svgRenderer*/) {
        //svgRenderer = ISVG(_svgRenderer);
    }

//    function initialize() public initializer {
//        jsonStart = 'data:application/json;base64,';
//        jsonEnd = '"}';
//    }

    //function to set the SVG renderer
//    function setSVGRenderer(address _svgRenderer) external {
//        svgRenderer = ISVG(_svgRenderer);
//    }

    function setBaseURI(string memory _baseURI) external {
        baseURI = _baseURI;
    }


    function prepareTokenURI(uint256 _id, uint256 _score, uint256 _level, Status _status) external view returns (string memory)
    {
        string memory statusString = statusToString(_status); // Convert status enum to string

        string memory attributes = string(abi.encodePacked(
            '{"name":"Plant #', Strings.toString(_id),
            '","attributes":[{"trait_type":"Score","value":"', Strings.toString(_score),
            '"},{"trait_type":"Level","value":"', Strings.toString(_level),
            '"},{"trait_type":"Status","value":"', statusString,
            '"}],"image": '
            //'"}],"image": "data:image/svg+xml;base64,'
        ));


        return string(abi.encodePacked(
            jsonStart,
            Base64.encode(bytes(string(
                abi.encodePacked(
                    attributes,
                    getImageUri(_level),
                    //Base64.encode(bytes(svgRenderer.Render(_level))),
                    jsonEnd
                )
            )))
        ));
    }


    function getImageUri(uint256 _level) public view returns (string memory) {
        //return ('"'+baseURI+Strings.toString(_level)+'.svg"');
        return append('"', baseURI, Strings.toString(_level), '.svg"');
    }


    function append(string memory a, string memory b, string memory c, string memory d) internal pure returns (string memory) {

    return string(abi.encodePacked(a, b, c, d));

}


    // Function to convert Status enum to string
    function statusToString(Status status) public pure returns (string memory) {
        if (status == Status.JOYFUL) {
            return "JOYFUL";
        } else if (status == Status.THIRSTY) {
            return "THIRSTY";
        } else if (status == Status.NEGLECTED) {
            return "NEGLECTED";
        } else if (status == Status.SICK) {
            return "SICK";
        } else if (status == Status.DEAD) {
            return "DEAD";
        } else if (status == Status.BURNED) {
            return "BURNED";
        }
        return ""; // Default case, should not happen
    }

}
