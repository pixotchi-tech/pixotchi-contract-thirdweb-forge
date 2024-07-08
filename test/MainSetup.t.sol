/*
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/entrypoint/PixotchiRouter.sol";
import "../src/nft/NFTLogic.sol";
import "../src/game/GameLogic.sol";
import "../src/garden/GardenLogic.sol";
import "../src/shop/ShopLogic.sol";
import "../src/nft/Renderer.sol";
import "../src/nft/ERC721AExtension.sol" as PixotchiERC721A;
import {BaseRouter, IRouter, IRouterState} from "../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import {IExtension} from "../lib/dynamic-contracts/src/interface/IExtension.sol";

contract MainSetupTest is Test, IExtension {
    using Strings for uint256;

    PixotchiRouter public router;
    NFTLogic public nftLogic;
    GameLogic public gameLogic;
    GardenLogic public gardenLogic;
    ShopLogic public shopLogic;
    Renderer public renderer;
    PixotchiERC721A.ERC721AExtension public pixotchiERC721AExtension;

    Extension internal nftLogicExtension;

    function setUp() public {
        // Deploy the router
        PixotchiRouter.SimpleRouterConstructorParams memory params;
        router = new PixotchiRouter(params);

        // Deploy other contracts
        nftLogic = new NFTLogic();
        gameLogic = new GameLogic();
        gardenLogic = new GardenLogic();
        shopLogic = new ShopLogic();
        renderer = new Renderer();
        pixotchiERC721AExtension = new PixotchiERC721A.ERC721AExtension();

        // Create extensions
        Extension[] memory extensions = new Extension[](6);
        extensions[0] = _createNFTLogicExtension();
        extensions[1] = _createGameLogicExtension();
        extensions[2] = _createGardenLogicExtension();
        extensions[3] = _createShopLogicExtension();
        extensions[4] = _createRendererExtension();
        extensions[5] = _createPixotchiERC721AExtension();

        // Add extensions to the router
        for (uint256 i = 0; i < extensions.length; i++) {
            router.addExtension(extensions[i]);
        }
    }

    function _createNFTLogicExtension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "NFTLogic";
        extension.metadata.metadataURI = "ipfs://NFTLogic";
        extension.metadata.implementation = address(nftLogic);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new ExtensionFunction[](28);
        extension.functions.push(ExtensionFunction(bytes4(keccak256("_getPlantsByOwner(address) returns (tuple[])")), "_getPlantsByOwner(address) returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("approve(address,uint256)")), "approve(address,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("balanceOf(address) returns (uint256)")), "balanceOf(address) returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("burn(uint256)")), "burn(uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getApproved(uint256) returns (address)")), "getApproved(uint256) returns (address)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantInfo(uint256) returns (tuple)")), "getPlantInfo(uint256) returns (tuple)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantInfoExtended(uint256) returns (tuple)")), "getPlantInfoExtended(uint256) returns (tuple)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantScore(uint256) returns (uint256)")), "getPlantScore(uint256) returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantTimeUntilStarving(uint256) returns (uint256)")), "getPlantTimeUntilStarving(uint256) returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantsByOwner(address) returns (tuple[])")), "getPlantsByOwner(address) returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantsByOwnerExtended(address) returns (tuple[])")), "getPlantsByOwnerExtended(address) returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantsInfo(uint256[]) returns (tuple[])")), "getPlantsInfo(uint256[]) returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantsInfoExtended(uint256[]) returns (tuple[])")), "getPlantsInfoExtended(uint256[]) returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("initializeNFTLogic()")), "initializeNFTLogic()"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("isApprovedForAll(address,address) returns (bool)")), "isApprovedForAll(address,address) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("mint(uint256)")), "mint(uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("name() returns (string)")), "name() returns (string)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("ownerOf(uint256) returns (address)")), "ownerOf(uint256) returns (address)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("removeTokenIdFromOwner(uint32,address) returns (bool)")), "removeTokenIdFromOwner(uint32,address) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("safeTransferFrom(address,address,uint256)")), "safeTransferFrom(address,address,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("safeTransferFrom(address,address,uint256,bytes)")), "safeTransferFrom(address,address,uint256,bytes)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("setApprovalForAll(address,bool)")), "setApprovalForAll(address,bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("supportsInterface(bytes4) returns (bool)")), "supportsInterface(bytes4) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("symbol() returns (string)")), "symbol() returns (string)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("tokenBurnAndRedistribute(address,uint256)")), "tokenBurnAndRedistribute(address,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("tokenURI(uint256) returns (string)")), "tokenURI(uint256) returns (string)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("totalSupply() returns (uint256)")), "totalSupply() returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("transferFrom(address,address,uint256)")), "transferFrom(address,address,uint256)"));
        // WARNING: Auto-generated code ends here.

        return extension;
    }

    function _createGameLogicExtension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "GameLogic";
        extension.metadata.metadataURI = "ipfs://GameLogic";
        extension.metadata.implementation = address(gameLogic);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new ExtensionFunction[](14);
        extension.functions.push(ExtensionFunction(bytes4(keccak256("attack(uint256,uint256)")), "attack(uint256,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getAllStrainInfo() returns (tuple[])")), "getAllStrainInfo() returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getPlantName(uint256) returns (string)")), "getPlantName(uint256) returns (string)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getStatus(uint256) returns (uint8)")), "getStatus(uint256) returns (uint8)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("isApprovedFn(uint256,address) returns (bool)")), "isApprovedFn(uint256,address) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("isPlantAlive(uint256) returns (bool)")), "isPlantAlive(uint256) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("kill(uint256,uint256)")), "kill(uint256,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("level(uint256) returns (uint256)")), "level(uint256) returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("onAttack(uint256,uint256) returns (uint256,uint256,bool)")), "onAttack(uint256,uint256) returns (uint256,uint256,bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("pass(uint256,uint256)")), "pass(uint256,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("pendingEth(uint256) returns (uint256)")), "pendingEth(uint256) returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("redeem(uint256)")), "redeem(uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("setPlantName(uint256,string)")), "setPlantName(uint256,string)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("statusToString(uint8) returns (string)")), "statusToString(uint8) returns (string)"));
        // WARNING: Auto-generated code ends here.

        return extension;
    }

    function _createGardenLogicExtension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "GardenLogic";
        extension.metadata.metadataURI = "ipfs://GardenLogic";
        extension.metadata.implementation = address(gardenLogic);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new ExtensionFunction[](9);
        extension.functions.push(ExtensionFunction(bytes4(keccak256("buyAccessory(uint256,uint256)")), "buyAccessory(uint256,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("createItem(string,uint256,uint256,uint256)")), "createItem(string,uint256,uint256,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("createItems(tuple[])")), "createItems(tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("editGardenItems(tuple[])")), "editGardenItems(tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("editItem(uint256,uint256,uint256,string,uint256)")), "editItem(uint256,uint256,uint256,string,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getAllGardenItem() returns (tuple[])")), "getAllGardenItem() returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getGardenItem(uint256) returns (tuple)")), "getGardenItem(uint256) returns (tuple)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("initializeGardenLogic()")), "initializeGardenLogic()"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("itemExists(uint256) returns (bool)")), "itemExists(uint256) returns (bool)"));
        // WARNING: Auto-generated code ends here.

        return extension;
    }

    function _createShopLogicExtension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "ShopLogic";
        extension.metadata.metadataURI = "ipfs://ShopLogic";
        extension.metadata.implementation = address(shopLogic);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new ExtensionFunction[](7);
        extension.functions.push(ExtensionFunction(bytes4(keccak256("reinitializer_8_ShopLogic()")), "reinitializer_8_ShopLogic()"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("shopBuyItem(uint256,uint256)")), "shopBuyItem(uint256,uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("shopDoesItemExist(uint256) returns (bool)")), "shopDoesItemExist(uint256) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("shopGetAllItems() returns (tuple[])")), "shopGetAllItems() returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("shopGetPurchasedItems(uint256) returns (tuple[])")), "shopGetPurchasedItems(uint256) returns (tuple[])"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("shopIsEffectOngoing(uint256,uint256) returns (bool)")), "shopIsEffectOngoing(uint256,uint256) returns (bool)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("shopModifyItem(uint256,string,uint256,uint256,uint256,uint256)")), "shopModifyItem(uint256,string,uint256,uint256,uint256,uint256)"));
        // WARNING: Auto-generated code ends here.

        return extension;
    }

    function _createRendererExtension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "Renderer";
        extension.metadata.metadataURI = "ipfs://Renderer";
        extension.metadata.implementation = address(renderer);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new ExtensionFunction[](3);
        extension.functions.push(ExtensionFunction(bytes4(keccak256("calculateImageLevel(uint256) returns (uint256)")), "calculateImageLevel(uint256) returns (uint256)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("getImageUri(uint256,string) returns (string)")), "getImageUri(uint256,string) returns (string)"));
        extension.functions.push(ExtensionFunction(bytes4(keccak256("prepareTokenURI(tuple,string) returns (string)")), "prepareTokenURI(tuple,string) returns (string)"));
        // WARNING: Auto-generated code ends here.

        return extension;
    }

    function _createPixotchiERC721AExtension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "PixotchiERC721AExtension";
        extension.metadata.metadataURI = "ipfs://PixotchiERC721AExtension";
        extension.metadata.implementation = address(pixotchiERC721AExtension);

        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new ExtensionFunction[](0);

        // WARNING: Auto-generated code ends here.

        return extension;
    }

    // Add test functions here...
}*/
