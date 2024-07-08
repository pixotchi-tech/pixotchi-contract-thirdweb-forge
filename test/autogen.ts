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
    const startMarker = `// WARNING: Auto-generated code starts here. Do not modify manually.`;
    const endMarker = `// WARNING: Auto-generated code ends here.`;
    const extensionRegex = new RegExp(`createExtension\\("${contractName}",[^;]+;([\\s\\S]*?)${startMarker}[\\s\\S]*?${endMarker}`);

    const updatedFunctions = functions.map(func => 
        `        extension.functions.push(BaseRouter.ExtensionFunction(${func.selector}, "${func.signature}"));`
    ).join('\n');

    const replacement = `createExtension("${contractName}", address(${contractName.toLowerCase()}));
        ${startMarker}
        extension.functions = new BaseRouter.ExtensionFunction[](${functions.length});
${updatedFunctions}
        ${endMarker}`;

    return testFileContent.replace(extensionRegex, replacement);
}

/**
 * Main function to orchestrate the update process
 * 
 * This function reads the MainSetup.t.sol file, processes each deployed contract, extracts function information from their ABI files, and updates the test file with the latest function definitions for all contract extensions.
 */
function main() {
    console.log('Starting main function');
    let testFileContent = fs.readFileSync(testFile, 'utf-8');

    // Find all deployed contracts in the test file
    const deployedContracts = testFileContent.match(/(\w+)\s*=\s*new\s+(\w+)\(\)/g);
    if (!deployedContracts) {
        console.error('No deployed contracts found in test file');
        return;
    }

    // Process each deployed contract
    for (const contract of deployedContracts) {
        const [, variableName, contractName] = contract.match(/(\w+)\s*=\s*new\s+(\w+)\(\)/) || [];
        if (!contractName) continue;

        console.log(`Processing contract: ${contractName}`);
        const functions = extractFunctionsFromABI(contractName);
        testFileContent = updateTestFile(testFileContent, contractName, functions);
    }

    // Write updated content back to the test file
    fs.writeFileSync(testFile, testFileContent);
    console.log('Test file updated successfully');
}

// Execute the main function
main();