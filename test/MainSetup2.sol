// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "./utils/MockContracts.sol";
import "./utils/Strings.sol";

import {SSTORE2} from "../lib/dynamic-contracts/lib/sstore2/contracts/SSTORE2.sol";
import {Bytecode} from "../lib/dynamic-contracts/lib/sstore2/contracts/utils/Bytecode.sol";
import {BaseRouter, IRouter, IRouterState} from "../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import {IExtension} from "../lib/dynamic-contracts/src/interface/IExtension.sol";

// New imports
import "./ExtensionData.sol";

/// @dev This custom router is written only for testing purposes and must not be used in production.
contract CustomRouter is BaseRouter {
    constructor(Extension[] memory _extensions) BaseRouter(_extensions) {}

    function initialize() public {
        __BaseRouter_init();
    }

    /// @dev Returns whether a function can be disabled in an extension in the given execution context.
    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
        return true;
    }
}

contract BaseRouterTest is Test, IExtension {
    
    using Strings for uint256;

    BaseRouter internal router;

    // New structs
    struct ExtensionCreationParams {
        string name;
        string metadataURI;
        address implementation;
        FunctionCreationParams[] functions;
    }

    struct FunctionCreationParams {
        bytes4 functionSelector;
        string functionSignature;
    }

    function setUp() public virtual {
        Extension[] memory defaultExtensions = createDefaultExtensions();
        router = BaseRouter(payable(address(new CustomRouter(defaultExtensions))));
        CustomRouter(payable(address(router))).initialize();
    }

    function createDefaultExtensions() internal returns (Extension[] memory) {
        ExtensionCreationParams[] memory params = new ExtensionCreationParams[](2);

        params[0] = ExtensionCreationParams({
            name: "MultiplyDivide",
            metadataURI: "ipfs://MultiplyDivide",
            implementation: address(new MultiplyDivide()),
            functions: new FunctionCreationParams[](2)
        });
        params[0].functions[0] = FunctionCreationParams(MultiplyDivide.multiplyNumber.selector, "multiplyNumber(uint256)");
        params[0].functions[1] = FunctionCreationParams(MultiplyDivide.divideNumber.selector, "divideNumber(uint256)");

        params[1] = ExtensionCreationParams({
            name: "AddSubstract",
            metadataURI: "ipfs://AddSubstract",
            implementation: address(new AddSubstract()),
            functions: new FunctionCreationParams[](2)
        });
        params[1].functions[0] = FunctionCreationParams(AddSubstract.addNumber.selector, "addNumber(uint256)");
        params[1].functions[1] = FunctionCreationParams(AddSubstract.subtractNumber.selector, "subtractNumber(uint256)");

        return createExtensions(params);
    }

    function createExtensions(ExtensionCreationParams[] memory params) internal pure returns (Extension[] memory) {
        Extension[] memory extensions = new Extension[](params.length);

        for (uint256 i = 0; i < params.length; i++) {
            extensions[i] = createExtension(params[i]);
        }

        return extensions;
    }

    function createExtension(ExtensionCreationParams memory params) internal pure returns (Extension memory) {
        Extension memory extension;

        extension.metadata.name = params.name;
        extension.metadata.metadataURI = params.metadataURI;
        extension.metadata.implementation = params.implementation;

        extension.functions = new ExtensionFunction[](params.functions.length);
        for (uint256 i = 0; i < params.functions.length; i++) {
            extension.functions[i] = createFunction(params.functions[i]);
        }

        return extension;
    }

    function createFunction(FunctionCreationParams memory params) internal pure returns (ExtensionFunction memory) {
        return ExtensionFunction(params.functionSelector, params.functionSignature);
    }

    function processExtensions(Extension[] memory extensions) internal {
        for (uint256 i = 0; i < extensions.length; i++) {
            Extension memory extension = extensions[i];
            processFunctions(extension);
        }
    }

    function processFunctions(Extension memory extension) internal {
        for (uint256 i = 0; i < extension.functions.length; i++) {
            ExtensionFunction memory func = extension.functions[i];
            // Process function logic here
            // For example, you could add the function to the router
            router.enableFunctionInExtension(extension.metadata.name, func);
        }
    }

    function test_createAndProcessExtensions() public {
        ExtensionCreationParams[] memory params = new ExtensionCreationParams[](1);

        params[0] = ExtensionCreationParams({
            name: "TestExtension",
            metadataURI: "ipfs://TestExtension",
            implementation: address(new IncrementDecrementGet()),
            functions: new FunctionCreationParams[](3)
        });
        params[0].functions[0] = FunctionCreationParams(IncrementDecrementGet.incrementNumber.selector, "incrementNumber()");
        params[0].functions[1] = FunctionCreationParams(IncrementDecrementGet.decrementNumber.selector, "decrementNumber()");
        params[0].functions[2] = FunctionCreationParams(IncrementDecrementGet.getNumber.selector, "getNumber()");

        Extension[] memory extensions = createExtensions(params);
        processExtensions(extensions);

        // Verify that the extension and its functions were added correctly
        Extension memory addedExtension = router.getExtension("TestExtension");
        assertEq(addedExtension.metadata.name, "TestExtension");
        assertEq(addedExtension.metadata.metadataURI, "ipfs://TestExtension");
        assertEq(addedExtension.metadata.implementation, address(extensions[0].metadata.implementation));
        assertEq(addedExtension.functions.length, 3);
    }

    function test_createExtensionsFromExternalData() public {
        ExtensionData extensionData = new ExtensionData();
        (string[] memory names, string[] memory metadataURIs, address[] memory implementations, bytes[] memory functionsData) = extensionData.getExtensionData();

        ExtensionCreationParams[] memory params = new ExtensionCreationParams[](names.length);

        for (uint256 i = 0; i < names.length; i++) {
            FunctionCreationParams[] memory functionParams = abi.decode(functionsData[i], (FunctionCreationParams[]));
            
            params[i] = ExtensionCreationParams({
                name: names[i],
                metadataURI: metadataURIs[i],
                implementation: implementations[i],
                functions: functionParams
            });
        }

        Extension[] memory extensions = createExtensions(params);
        processExtensions(extensions);

        // Verify that the extensions and their functions were added correctly
        for (uint256 i = 0; i < names.length; i++) {
            Extension memory addedExtension = router.getExtension(names[i]);
            assertEq(addedExtension.metadata.name, names[i]);
            assertEq(addedExtension.metadata.metadataURI, metadataURIs[i]);
            assertEq(addedExtension.metadata.implementation, implementations[i]);
            
            FunctionCreationParams[] memory functionParams = abi.decode(functionsData[i], (FunctionCreationParams[]));
            assertEq(addedExtension.functions.length, functionParams.length);
        }
    }

    // ... (keep the rest of the existing tests)
}