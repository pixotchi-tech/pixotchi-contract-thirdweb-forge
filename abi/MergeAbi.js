const fs = require('fs');
const path = require('path');

// Function to recursively get all .sol files and extract filenames
function getSolFiles(dir, files = []) {
    const items = fs.readdirSync(dir);
    for (const item of items) {
        const fullPath = path.join(dir, item);
        if (fs.statSync(fullPath).isDirectory()) {
            getSolFiles(fullPath, files);
        } else if (path.extname(fullPath) === '.sol') {
            files.push(path.basename(fullPath, '.sol'));
        }
    }
    return files;
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

// Main function
function main() {
    const srcDir = 'src';
    const solFiles = getSolFiles(srcDir);
    console.log('Solidity files:', solFiles);

    const mergedABI = mergeABIs(solFiles);
    if (mergedABI.length > 0) {
        const abiDir = 'abi';
        if (!fs.existsSync(abiDir)) {
            fs.mkdirSync(abiDir);
        }

        const abiJsonPath = path.join(abiDir, 'PixotchiV2Abi.json');
        const abiJsonMinPath = path.join(abiDir, 'PixotchiV2Abi.min.json');
        fs.writeFileSync(abiJsonPath, JSON.stringify(mergedABI, null, 2));
        fs.writeFileSync(abiJsonMinPath, JSON.stringify(mergedABI));
        console.log(`Merged ABI saved to ${abiJsonPath} and ${abiJsonMinPath}`);

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