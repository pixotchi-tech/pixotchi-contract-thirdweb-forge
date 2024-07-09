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
    address public owner;

    constructor(Extension[] memory _extensions) BaseRouter(_extensions) {
        owner = msg.sender;
    }

    function initialize() public {
        __BaseRouter_init();
    }

    function addExtension(Extension memory extension) public override {
        super.addExtension(extension);
        // Add a log to confirm the extension was added
        console.log("Extension added:", extension.metadata.name);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    /// @dev Returns whether a function can be disabled in an extension in the given execution context.
    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
        return true;
    }

    // Add this receive function
    receive() external payable {}
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
            console.log("Processing extension:", extension.metadata.name);
            
            // Check if the extension already exists before adding
            if (!_extensionExists(extension.metadata.name)) {
                console.log("Adding extension:", extension.metadata.name);
                router.addExtension(extension);
                
                // Verify that the extension was added successfully
                Extension memory addedExtension = router.getExtension(extension.metadata.name);
                console.log("Retrieved extension name:", addedExtension.metadata.name);
                console.log("Retrieved extension metadataURI:", addedExtension.metadata.metadataURI);
                console.log("Retrieved extension implementation:", addedExtension.metadata.implementation);
                console.log("Retrieved extension functions count:", addedExtension.functions.length);
                
                require(keccak256(abi.encodePacked(addedExtension.metadata.name)) == keccak256(abi.encodePacked(extension.metadata.name)), 
                        string(abi.encodePacked("Failed to add extension: ", extension.metadata.name)));
                
                processFunctions(extension);
            } else {
                console.log("Extension already exists:", extension.metadata.name);
            }
        }
    }

    function processFunctions(Extension memory extension) internal {
        for (uint256 i = 0; i < extension.functions.length; i++) {
            ExtensionFunction memory func = extension.functions[i];
            // We'll enable all functions, as we can't easily check if they're already enabled
            router.enableFunctionInExtension(extension.metadata.name, func);
        }
    }

    // Helper function to check if an extension exists
    function _extensionExists(string memory extensionName) internal view returns (bool) {
        try router.getExtension(extensionName) {
            return true;
        } catch {
            return false;
        }
    }

    function _printExtensionDetails(string memory extensionName) internal view {
        Extension memory ext = router.getExtension(extensionName);
        console.log("Extension Name:", ext.metadata.name);
        console.log("Extension MetadataURI:", ext.metadata.metadataURI);
        console.log("Extension Implementation:", ext.metadata.implementation);
        console.log("Number of Functions:", ext.functions.length);
    }

    function _printRouterState() internal view {
        console.log("Router address:", address(router));
        console.log("Router owner:", CustomRouter(payable(address(router))).getOwner());
        Extension[] memory extensions = router.getAllExtensions();
        console.log("Router extension count:", extensions.length);
        
        console.log("Extensions:");
        for (uint i = 0; i < extensions.length; i++) {
            console.log(extensions[i].metadata.name);
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

        _printRouterState();
        Extension[] memory extensions = createExtensions(params);
        processExtensions(extensions);
        _printRouterState();

        _printExtensionDetails("TestExtension");

        // Verify that the extension and its functions were added correctly
        Extension memory addedExtension = router.getExtension("TestExtension");
        emit log_named_string("Expected Extension Name", "TestExtension");
        emit log_named_string("Actual Extension Name", addedExtension.metadata.name);
        assertEq(addedExtension.metadata.name, "TestExtension", "Extension name mismatch");
        assertEq(addedExtension.metadata.metadataURI, "ipfs://TestExtension", "Extension metadataURI mismatch");
        assertEq(addedExtension.metadata.implementation, address(extensions[0].metadata.implementation), "Extension implementation mismatch");
        assertEq(addedExtension.functions.length, 3, "Incorrect number of functions");
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

        _printRouterState();
        Extension[] memory extensions = createExtensions(params);
        processExtensions(extensions);
        _printRouterState();

        for (uint256 i = 0; i < names.length; i++) {
            _printExtensionDetails(names[i]);

            // Verify that the extensions and their functions were added correctly
            Extension memory addedExtension = router.getExtension(names[i]);
            emit log_named_string("Expected Extension Name", names[i]);
            emit log_named_string("Actual Extension Name", addedExtension.metadata.name);
            assertEq(addedExtension.metadata.name, names[i], "Extension name mismatch");
            assertEq(addedExtension.metadata.metadataURI, metadataURIs[i], "Extension metadataURI mismatch");
            assertEq(addedExtension.metadata.implementation, implementations[i], "Extension implementation mismatch");
            
            FunctionCreationParams[] memory functionParams = abi.decode(functionsData[i], (FunctionCreationParams[]));
            assertEq(addedExtension.functions.length, functionParams.length, "Incorrect number of functions");
        }
    }

    // ... existing code ...
}