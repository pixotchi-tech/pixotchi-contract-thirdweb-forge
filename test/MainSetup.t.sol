// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/entrypoint/PixotchiRouter.sol";
import "../src/nft/NFTLogic.sol";
import "../src/game/GameLogic.sol";
import "../src/garden/GardenLogic.sol";
import "../src/shop/ShopLogic.sol";
import "../src/nft/Renderer.sol";
import "../src/nft/ERC721AExtension.sol";

contract MainSetupTest is Test {
    PixotchiRouter public router;
    NFTLogic public nftLogic;
    GameLogic public gameLogic;
    GardenLogic public gardenLogic;
    ShopLogic public shopLogic;
    Renderer public renderer;
    ERC721AExtension public erc721AExtension;

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
        erc721AExtension = new ERC721AExtension();

        // Create extensions
        BaseRouter.Extension[] memory extensions = new BaseRouter.Extension[](6);
        extensions[0] = createExtension("NFTLogic", address(nftlogic));
        // WARNING: Auto-generated code starts here. Do not modify manually.
        extension.functions = new BaseRouter.ExtensionFunction[](28);
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("_getPlantsByOwner(address) returns (tuple[])")), "_getPlantsByOwner(address) returns (tuple[])"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("approve(address,uint256)")), "approve(address,uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("balanceOf(address) returns (uint256)")), "balanceOf(address) returns (uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("burn(uint256)")), "burn(uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getApproved(uint256) returns (address)")), "getApproved(uint256) returns (address)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantInfo(uint256) returns (tuple)")), "getPlantInfo(uint256) returns (tuple)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantInfoExtended(uint256) returns (tuple)")), "getPlantInfoExtended(uint256) returns (tuple)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantScore(uint256) returns (uint256)")), "getPlantScore(uint256) returns (uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantTimeUntilStarving(uint256) returns (uint256)")), "getPlantTimeUntilStarving(uint256) returns (uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantsByOwner(address) returns (tuple[])")), "getPlantsByOwner(address) returns (tuple[])"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantsByOwnerExtended(address) returns (tuple[])")), "getPlantsByOwnerExtended(address) returns (tuple[])"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantsInfo(uint256[]) returns (tuple[])")), "getPlantsInfo(uint256[]) returns (tuple[])"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("getPlantsInfoExtended(uint256[]) returns (tuple[])")), "getPlantsInfoExtended(uint256[]) returns (tuple[])"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("initializeNFTLogic()")), "initializeNFTLogic()"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("isApprovedForAll(address,address) returns (bool)")), "isApprovedForAll(address,address) returns (bool)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("mint(uint256)")), "mint(uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("name() returns (string)")), "name() returns (string)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("ownerOf(uint256) returns (address)")), "ownerOf(uint256) returns (address)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("removeTokenIdFromOwner(uint32,address) returns (bool)")), "removeTokenIdFromOwner(uint32,address) returns (bool)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("safeTransferFrom(address,address,uint256)")), "safeTransferFrom(address,address,uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("safeTransferFrom(address,address,uint256,bytes)")), "safeTransferFrom(address,address,uint256,bytes)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("setApprovalForAll(address,bool)")), "setApprovalForAll(address,bool)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("supportsInterface(bytes4) returns (bool)")), "supportsInterface(bytes4) returns (bool)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("symbol() returns (string)")), "symbol() returns (string)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("tokenBurnAndRedistribute(address,uint256)")), "tokenBurnAndRedistribute(address,uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("tokenURI(uint256) returns (string)")), "tokenURI(uint256) returns (string)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("totalSupply() returns (uint256)")), "totalSupply() returns (uint256)"));
        extension.functions.push(BaseRouter.ExtensionFunction(bytes4(keccak256("transferFrom(address,address,uint256)")), "transferFrom(address,address,uint256)"));
        // WARNING: Auto-generated code ends here.

        return extension;
    }
}