// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/entrypoint/PixotchiRouter.sol";
import "../src/nft/NFTLogic.sol";
import {GameLogic as PixotchiGameLogic} from "../src/game/GameLogic.sol";
import "../src/garden/GardenLogic.sol";
import {ShopLogic as PixotchiShopLogic} from "../src/shop/ShopLogic.sol";
import {Renderer as PixotchiRenderer} from "../src/nft/Renderer.sol";
import {ERC721AExtension as PixotchiERC721AExtension} from "../src/nft/ERC721AExtension.sol";
//import "/lib/src/interface/IExtension.sol";
//import "src/presets/BaseRouter.sol";
import {BaseRouter, IRouter, IRouterState} from "../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import {IExtension} from "../lib/dynamic-contracts/src/interface/IExtension.sol";

contract MainSetupTest is Test, IExtension {
    using Strings for uint256;

    PixotchiRouter public router;
    NFTLogic public nftLogic;
    PixotchiGameLogic public gameLogic;
    GardenLogic public gardenLogic;
    PixotchiShopLogic public shopLogic;
    PixotchiRenderer public renderer;
    PixotchiERC721AExtension public erc721AExtension;

    Extension internal nftLogicExtension;

    function setUp() public {
        // Deploy the router
        PixotchiRouter.SimpleRouterConstructorParams memory params;
        router = new PixotchiRouter(params);

        // Deploy other contracts
        nftLogic = new NFTLogic();
        gameLogic = new PixotchiGameLogic();
        gardenLogic = new GardenLogic();
        shopLogic = new PixotchiShopLogic();
        renderer = new PixotchiRenderer();
        erc721AExtension = new PixotchiERC721AExtension();

        // Create extensions
        Extension[] memory extensions = new Extension[](1);
        extensions[0] = _createNFTLogicExtension();

        // Add extensions to the router
        for (uint256 i = 0; i < extensions.length; i++) {
            router.addExtension(extensions[i]);
        }
    }

    function _createNFTLogicExtension() internal returns (Extension memory) {
        nftLogicExtension.metadata.name = "NFTLogic";
        nftLogicExtension.metadata.metadataURI = "ipfs://NFTLogic";
        nftLogicExtension.metadata.implementation = address(nftLogic);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        delete nftLogicExtension.functions; // Clear existing functions
        nftLogicExtension.functions.push(ExtensionFunction(bytes4(keccak256("_getPlantsByOwner(address)")), "_getPlantsByOwner(address) returns (tuple[])"));
        nftLogicExtension.functions.push(ExtensionFunction(bytes4(keccak256("approve(address,uint256)")), "approve(address,uint256)"));
        // ... Add the rest of the functions here ...
        nftLogicExtension.functions.push(ExtensionFunction(bytes4(keccak256("transferFrom(address,address,uint256)")), "transferFrom(address,address,uint256)"));
        // WARNING: Auto-generated code ends here.

        return nftLogicExtension;
    }

    function test_nftLogicExtensionSetup() public {
        Extension memory storedExtension = router.getExtension("NFTLogic");
        assertEq(storedExtension.metadata.name, nftLogicExtension.metadata.name);
        assertEq(storedExtension.metadata.metadataURI, nftLogicExtension.metadata.metadataURI);
        assertEq(storedExtension.metadata.implementation, nftLogicExtension.metadata.implementation);
        assertEq(storedExtension.functions.length, nftLogicExtension.functions.length);
    }

    // Add more test functions here...
}