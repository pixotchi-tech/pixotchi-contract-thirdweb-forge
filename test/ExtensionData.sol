// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ExtensionData {
    struct FunctionCreationParams {
        bytes4 functionSelector;
        string functionSignature;
    }

    function getExtensionData() public pure returns (
        string[] memory names,
        string[] memory metadataURIs,
        address[] memory implementations,
        bytes[] memory functionsData
    ) {
        names = new string[](2);
        metadataURIs = new string[](2);
        implementations = new address[](2);
        functionsData = new bytes[](2);

        names[0] = "ExternalExtension1";
        metadataURIs[0] = "ipfs://ExternalExtension1";
        implementations[0] = address(0x1111111111111111111111111111111111111111);

        FunctionCreationParams[] memory functions1 = new FunctionCreationParams[](2);
        functions1[0] = FunctionCreationParams(bytes4(keccak256("externalFunction1()")), "externalFunction1()");
        functions1[1] = FunctionCreationParams(bytes4(keccak256("externalFunction2(uint256)")), "externalFunction2(uint256)");
        functionsData[0] = abi.encode(functions1);

        names[1] = "ExternalExtension2";
        metadataURIs[1] = "ipfs://ExternalExtension2";
        implementations[1] = address(0x2222222222222222222222222222222222222222);

        FunctionCreationParams[] memory functions2 = new FunctionCreationParams[](1);
        functions2[0] = FunctionCreationParams(bytes4(keccak256("externalFunction3(address)")), "externalFunction3(address)");
        functionsData[1] = abi.encode(functions2);
    }
}