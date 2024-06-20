const fs = require('fs');
const path = require('path');

// Array of filenames to skip
const skipFiles = [
    'NFTLogicDelegations',
    'ERC2771ContextConsumer',
    'FixedPointMathLib',
    'PixotchiExtensionPermission'
];

// Function to recursively get all .sol files and extract filenames
function getSolFiles(dir, files = [], skippedFiles = []) {
    const items = fs.readdirSync(dir);
    for (const item of items) {
        const fullPath = path.join(dir, item);
        if (fs.statSync(fullPath).isDirectory()) {
            getSolFiles(fullPath, files, skippedFiles);
        } else if (path.extname(fullPath) === '.sol') {
            const fileName = path.basename(fullPath, '.sol');
            if (
                fileName.startsWith('I') ||
                fileName.endsWith('Storage') ||
                fileName.endsWith('Library') ||
                skipFiles.includes(fileName)
            ) {
                skippedFiles.push(fileName);
            } else {
                files.push(fileName);
            }
        }
    }
    return { files, skippedFiles };
}

// Function to merge ABIs from JSON files
function mergeABIs(files) {
    let mergedABI = [];
    for (const file of files) {
        const jsonFilePath = path.join('out', `${file}.sol`, `${file}.json`);
        if (fs.existsSync(jsonFilePath)) {
            const jsonData = JSON.parse(fs.readFileSync(jsonFilePath, 'utf8'));
            if (jsonData.abi) {
                mergedABI = mergedABI.concat(jsonData.abi);
            }
        }
    }
    return mergedABI;
}

// Function to create a human-readable ABI
function createHumanReadableABI(abi) {
    return abi.map(item => {
        if (item.type === 'function') {
            const inputs = item.inputs.map(input => `${input.type} ${input.name}`).join(', ');
            const outputs = item.outputs.map(output => output.type).join(', ');
            return `function ${item.name}(${inputs}) ${item.stateMutability} returns (${outputs})`;
        } else if (item.type === 'event') {
            const inputs = item.inputs.map(input => `${input.indexed ? 'indexed ' : ''}${input.type} ${input.name}`).join(', ');
            return `event ${item.name}(${inputs})`;
        } else if (item.type === 'error') {
            const inputs = item.inputs.map(input => `${input.type} ${input.name}`).join(', ');
            return `error ${item.name}(${inputs})`;
        }
        return '';
    });
}

// Main function
function main() {
    const srcDir = 'src';
    const { files: solFiles, skippedFiles } = getSolFiles(srcDir);
    console.log('Solidity files:', solFiles);
    console.log('Skipped files:', skippedFiles);

    const mergedABI = mergeABIs(solFiles);
    if (mergedABI.length > 0) {
        const abiDir = 'abi/output';
        if (!fs.existsSync(abiDir)) {
            fs.mkdirSync(abiDir);
        }

        const abiJsonPath = path.join(abiDir, 'PixotchiV2Abi.json');
        const abiJsonMinPath = path.join(abiDir, 'PixotchiV2Abi.min.json');
        fs.writeFileSync(abiJsonPath, JSON.stringify(mergedABI, null, 2));
        fs.writeFileSync(abiJsonMinPath, JSON.stringify(mergedABI));
        console.log(`Merged ABI saved to ${abiJsonPath} and ${abiJsonMinPath}`);

        const humanReadableABI = createHumanReadableABI(mergedABI);
        const humanReadableAbiPath = path.join(abiDir, 'PixotchiV2Abi.human.json');
        fs.writeFileSync(humanReadableAbiPath, JSON.stringify(humanReadableABI, null, 2));
        console.log(`Human-readable ABI saved to ${humanReadableAbiPath}`);

        const tsFilePath = path.join(abiDir, 'PixotchiV2Contract.ts');
        const tsFileMinPath = path.join(abiDir, 'PixotchiV2Contract.min.ts');
        const tsContent = `
import { getAddress } from "viem";

export const PixotchiV2Abi = ${JSON.stringify(mergedABI, null, 2)} as const;

export const PixotchiV2Contract = {
    address: getAddress(process.env.PIXOTCHI_NFT_CONTRACT_ADDRESS_V2!),
    abi: PixotchiV2Abi,
} as const;
        `;
        const tsContentMin = `
import { getAddress } from "viem";

export const PixotchiV2Abi = ${JSON.stringify(mergedABI)} as const;

export const PixotchiV2Contract = {
    address: getAddress(process.env.PIXOTCHI_NFT_CONTRACT_ADDRESS_V2!),
    abi: PixotchiV2Abi,
} as const;
        `;
        fs.writeFileSync(tsFilePath, tsContent.trim());
        fs.writeFileSync(tsFileMinPath, tsContentMin.trim());
        console.log(`TypeScript contract file saved to ${tsFilePath} and ${tsFileMinPath}`);
    } else {
        console.log('No ABI found in the JSON files.');
    }
}

main();
