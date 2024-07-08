import * as fs from 'fs';
import * as path from 'path';

// Define paths for the test file and output directory
const testFile = path.join(__dirname, '..', 'test', 'MainSetup.t.sol');
const outDir = path.join(__dirname, '..', 'out');

// Define the structure for contract functions
interface ContractFunction {
    selector: string;  // Function selector (bytes4 hash)
    signature: string; // Function signature
}

/**
 * Extracts functions from a contract's ABI file
 * @param contractName - Name of the contract
 * @returns Array of ContractFunction objects
 * 
 * This function reads and processes the ABI file for a given contract, extracting function definitions to generate signatures and selectors for smart contract integration.
 */
function extractFunctionsFromABI(contractName: string): ContractFunction[] {
    const abiPath = path.join(outDir, `${contractName}.sol`, `${contractName}.json`);
    console.log(`Extracting functions from ABI: ${abiPath}`);

    // Check if ABI file exists
    if (!fs.existsSync(abiPath)) {
        console.error(`ABI file not found: ${abiPath}`);
        return [];
    }

    // Read and parse ABI file
    const abiContent = JSON.parse(fs.readFileSync(abiPath, 'utf-8'));
    const abi = abiContent.abi;

    // Validate ABI content
    if (!Array.isArray(abi) || abi.length === 0) {
        console.log(`Empty or invalid ABI for ${contractName}`);
        return [];
    }

    // Extract function definitions
    const functions: ContractFunction[] = abi
        .filter(item => item.type === 'function')
        .map(func => {
            const inputs = func.inputs.map((input: { type: string }) => input.type).join(',');
            const outputs = func.outputs ? func.outputs.map((output: { type: string }) => output.type).join(',') : '';
            const signature = `${func.name}(${inputs})${outputs ? ` returns (${outputs})` : ''}`;
            const selector = `bytes4(keccak256("${signature}"))`;
            console.log(`Adding function: ${signature}`);
            return { selector, signature };
        });

    return functions;
}

/**
 * Updates the test file with extracted function information
 * @param testFileContent - Content of the test file
 * @param contractName - Name of the contract being updated
 * @param functions - Array of extracted functions
 * @returns Updated test file content
 * 
 * This function modifies the MainSetup.t.sol file to include updated function selectors and signatures for each contract extension, ensuring the test file reflects the latest contract definitions.
 */
function updateTestFile(testFileContent: string, contractName: string, functions: ContractFunction[]): string {
    console.log(`Updating test file for contract: ${contractName}`);
    const functionName = `_create${contractName}Extension`;
    const functionRegex = new RegExp(`function\\s+${functionName}\\s*\\([^)]*\\)\\s*internal\\s+returns\\s*\\(Extension\\s+memory\\)\\s*{[\\s\\S]*?}`);

    console.log(`Searching for function: ${functionName}`);

    const match = testFileContent.match(functionRegex);
    if (!match) {
        console.log(`Function ${functionName} not found in the test file.`);
        return testFileContent;
    }

    const existingFunction = match[0];
    console.log(`Existing function found: ${existingFunction.substring(0, 100)}...`);

    const updatedFunctions = functions.map(func => 
        `        extension.functions.push(ExtensionFunction(${func.selector}, "${func.signature}"));`
    ).join('\n');

    const updatedFunction = existingFunction.replace(
        /(\/\/ WARNING: Auto-generated code starts here\. Do not modify manually\.)([\s\S]*?)(\/\/ WARNING: Auto-generated code ends here\.)/,
        `$1\n        extension.functions = new ExtensionFunction[](${functions.length});\n${updatedFunctions}\n        $3`
    );

    console.log(`Updated function: ${updatedFunction.substring(0, 100)}...`);

    const newContent = testFileContent.replace(existingFunction, updatedFunction);

    if (newContent === testFileContent) {
        console.log(`WARNING: No changes made for ${contractName}. Function content might be identical.`);
    } else {
        console.log(`Content updated for ${contractName}`);
    }

    return newContent;
}

/**
 * Main function to orchestrate the update process
 * 
 * This function reads the MainSetup.t.sol file, processes each deployed contract, extracts function information from their ABI files, and updates the test file with the latest function definitions for all contract extensions.
 */
function main() {
    console.log('Starting main function');
    let testFileContent = fs.readFileSync(testFile, 'utf-8');
    console.log('Current content of MainSetup.t.sol:');
    console.log(testFileContent);
    console.log(`Initial test file content length: ${testFileContent.length}`);

    // Find all deployed contracts in the test file
    const deployedContracts = testFileContent.match(/(\w+)\s*=\s*new\s+(\w+)(?:\.(\w+))?\(\)/g);
    if (!deployedContracts) {
        console.error('No deployed contracts found in test file');
        return;
    }

    console.log(`Found ${deployedContracts.length} deployed contracts`);

    // Process each deployed contract
    for (const contract of deployedContracts) {
        const [, variableName, contractName] = contract.match(/(\w+)\s*=\s*new\s+(\w+)(?:\.(\w+))?\(\)/) || [];
        if (!contractName) continue;

        let extensionName = contractName;
        if (contractName === "ERC721AExtension") {
            extensionName = "PixotchiERC721AExtension";
        }

        const functionName = `_create${extensionName}Extension`;
        if (testFileContent.includes(functionName)) {
            console.log(`Processing contract: ${extensionName}`);
            const functions = extractFunctionsFromABI(contractName);
            const updatedContent = updateTestFile(testFileContent, extensionName, functions);
            
            if (updatedContent !== testFileContent) {
                testFileContent = updatedContent;
                console.log(`Test file content updated for ${extensionName}`);
            } else {
                console.log(`No changes made for ${extensionName}`);
            }
        } else {
            console.log(`Creating new extension function for ${extensionName}`);
            const newFunction = createNewExtensionFunction(extensionName, variableName);
            testFileContent += `\n${newFunction}\n`;
            const functions = extractFunctionsFromABI(contractName);
            testFileContent = updateTestFile(testFileContent, extensionName, functions);
        }
    }

    console.log(`Final test file content length: ${testFileContent.length}`);

    // Write updated content back to the test file
    fs.writeFileSync(testFile, testFileContent);
    console.log('Test file written successfully');
}

function createNewExtensionFunction(contractName: string, variableName: string): string {
    return `
    function _create${contractName}Extension() internal returns (Extension memory) {
        Extension memory extension;
        extension.metadata.name = "${contractName}";
        extension.metadata.metadataURI = "ipfs://${contractName}";
        extension.metadata.implementation = address(${variableName});

        // WARNING: Auto-generated code starts here. Do not modify manually.
        // Functions will be added here
        // WARNING: Auto-generated code ends here.

        return extension;
    }`;
}

// Execute the main function
main();