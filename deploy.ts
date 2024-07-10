import { createInterface } from 'node:readline/promises';
import type { Interface } from 'node:readline/promises';
import { config } from 'dotenv';
import { createThirdwebClient, getContract, prepareContractCall, sendAndConfirmTransaction, readContract } from 'thirdweb';
import { privateKeyToAccount } from 'thirdweb/wallets';
import { base, baseSepolia } from "thirdweb/chains";
import fs from 'fs/promises';
import path from 'path';
import {AbiRouter} from "./abi/AbiRouter";

config();

// Add this constant near the top of the file
const EXPLORER_URL = process.env.EXPLORER_URL || 'https://basescan.org/';
const EXPLORER_URL_TESTNET = process.env.EXPLORER_URL || 'https://sepolia.basescan.org/';

/**
 * @dev Interface for the result of the setupClient function.
 */
interface SetupClientResult {
    client: ReturnType<typeof createThirdwebClient>;
    routerContract: ReturnType<typeof getContract>;
    account: ReturnType<typeof privateKeyToAccount>;
}

/**
 * @dev Sets up the Thirdweb client, contract, and account.
 * @return {Promise<SetupClientResult>} The client, contract, and account.
 */
async function setupClient(isTestnet: boolean): Promise<SetupClientResult> {
    const client = createThirdwebClient({
        clientId: process.env.CLIENT_ID!
    });

    const chain = isTestnet ? baseSepolia : base;
    const routerAddress = isTestnet ? process.env.ROUTER_CONTRACT_ADDRESS_TESTNET! : process.env.ROUTER_CONTRACT_ADDRESS!;
    const privateKey = isTestnet ? process.env.PRIVATE_KEY_ADMIN_TESTNET! : process.env.PRIVATE_KEY_ADMIN!;

    const routerContract = getContract({
        client,
        chain,
        address: routerAddress,
        abi: AbiRouter
    });

    const account = privateKeyToAccount({ client, privateKey });

    return { client, routerContract, account };
}

async function readDeployArgs(): Promise<any> {
    const filePath = path.join(__dirname, 'deployArgs.json');
    const fileContent = await fs.readFile(filePath, 'utf-8');
    return JSON.parse(fileContent);
}

async function writeDeployArgs(data: any): Promise<void> {
    const filePath = path.join(__dirname, 'deployArgs.json');
    await fs.writeFile(filePath, JSON.stringify(data, null, 2));
}

async function setupReadline(): Promise<Interface> {
    return createInterface({
        input: process.stdin,
        output: process.stdout
    });
}

async function askQuestion(rl: Interface, question: string): Promise<string> {
    const answer = await rl.question(question);
    return answer.trim();
}

async function selectExtension(extensions: Array<{ metadata: { name: string, implementation: string } }>, rl: Interface): Promise<any> {
    console.log("Available extensions:");
    extensions.forEach((ext, index) => {
        console.log(`${index + 1}. ${ext.metadata.name}`);
    });

    const selection = await askQuestion(rl, "Select an extension to add (enter the number): ");
    const selectedExtension = extensions[parseInt(selection) - 1];

    if (!selectedExtension) {
        console.log("Invalid selection. Please try again.");
        return null;
    }

    console.log(`You selected: ${selectedExtension.metadata.name}`);

    if (selectedExtension.metadata.implementation === "0x0000000000000000000000000000000000000000") {
        console.warn("Warning: Implementation address is zero. Please provide a new address.");
        const newAddress = await askQuestion(rl, "Enter new implementation address: ");
        selectedExtension.metadata.implementation = newAddress;
        await writeDeployArgs({ extensions });
    }

    return selectedExtension;
}

async function addExtension(routerContract: any, account: any, rl: Interface, isTestnet: boolean): Promise<void> {
    const { extensions } = await readDeployArgs();
    const selectedExtension = await selectExtension(extensions, rl);

    const transaction = await prepareContractCall({
        contract: routerContract,
        method: "function addExtension(((string name, string metadataURI, address implementation) metadata, (bytes4 functionSelector, string functionSignature)[] functions) _extension)",
        params: [selectedExtension]
    });

    console.log("Sending transaction to add extension...");
    const txResult = await sendAndConfirmTransaction({
        transaction,
        account
    });

    const explorerUrl = isTestnet ? EXPLORER_URL_TESTNET : EXPLORER_URL;
    console.log("Extension added. Transaction hash:", txResult.transactionHash);
    console.log("Explorer link:", `${explorerUrl}tx/${txResult.transactionHash}`);
}

async function replaceExtension(routerContract: any, account: any, rl: Interface, isTestnet: boolean): Promise<void> {
    const { extensions } = await readDeployArgs();
    console.log("Available extensions:");
    extensions.forEach((ext: { metadata: { name: string } }, index: number) => {
        console.log(`${index + 1}. ${ext.metadata.name}`);
    });

    let selectedExtension;
    while (!selectedExtension) {
        const selection = await askQuestion(rl, "Select an extension to replace (enter the number): ");
        selectedExtension = extensions[parseInt(selection) - 1];
        if (!selectedExtension) {
            console.log("Invalid selection. Please try again.");
        }
    }

    console.log(`You selected: ${selectedExtension.metadata.name}`);
    console.log("Current implementation address:", selectedExtension.metadata.implementation);

    const newAddress = await askQuestion(rl, "Enter new implementation address (or press Enter to keep current): ");

    if (newAddress) {
        selectedExtension.metadata.implementation = newAddress;
        await writeDeployArgs({ extensions });
    }

    const transaction = await prepareContractCall({
        contract: routerContract,
        method: "function replaceExtension(((string name, string metadataURI, address implementation) metadata, (bytes4 functionSelector, string functionSignature)[] functions) _extension)",
        params: [selectedExtension]
    });

    console.log("Sending transaction to replace extension...");
    const txResult = await sendAndConfirmTransaction({
        transaction,
        account
    });

    const explorerUrl = isTestnet ? EXPLORER_URL_TESTNET : EXPLORER_URL;
    console.log("Extension replaced. Transaction hash:", txResult.transactionHash);
    console.log("Explorer link:", `${explorerUrl}tx/${txResult.transactionHash}`);
}

async function removeExtension(routerContract: any, account: any, rl: Interface, isTestnet: boolean): Promise<void> {
    const extensionName = await askQuestion(rl, "Enter the name of the extension to remove: ");

    const transaction = await prepareContractCall({
        contract: routerContract,
        method: "function removeExtension(string _extensionName)",
        params: [extensionName]
    });

    console.log("Sending transaction to remove extension...");
    const txResult = await sendAndConfirmTransaction({
        transaction,
        account
    });

    const explorerUrl = isTestnet ? EXPLORER_URL_TESTNET : EXPLORER_URL;
    console.log("Extension removed. Transaction hash:", txResult.transactionHash);
    console.log("Explorer link:", `${explorerUrl}tx/${txResult.transactionHash}`);
}

async function getAllExtensions(routerContract: ReturnType<typeof getContract>): Promise<void> {
    try {
        const allExtensions = await readContract({
            contract: routerContract,
            method: "function getAllExtensions()",
            params: []
        });

        console.log("All extensions:", JSON.stringify(allExtensions, null, 2));
    } catch (error) {
        console.error("Error fetching extensions:", error);
    }
}

async function main(): Promise<void> {
    console.log("Starting Router CLI...");

    const rl = await setupReadline();

    try {
        const networkChoice = await askQuestion(rl, "Select network (1 for Base Mainnet, 2 for Base Testnet): ");
        const isTestnet = networkChoice === "2";

        const { routerContract, account } = await setupClient(isTestnet);

        while (true) {
            console.log("\nWhat would you like to do?");
            console.log("1. Add Extension");
            console.log("2. Replace Extension");
            console.log("3. Remove Extension");
            console.log("4. Get All Extensions");
            console.log("5. Exit");

            const action = await askQuestion(rl, "Enter your choice (1-5): ");

            switch (action) {
                case '1':
                    await addExtension(routerContract, account, rl, isTestnet);
                    break;
                case '2':
                    await replaceExtension(routerContract, account, rl, isTestnet);
                    break;
                case '3':
                    await removeExtension(routerContract, account, rl, isTestnet);
                    break;
                case '4':
                    await getAllExtensions(routerContract);
                    break;
                case '5':
                    console.log("Exiting CLI...");
                    return;
                default:
                    console.log("Invalid choice. Please try again.");
            }
        }
    } finally {
        rl.close();
    }
}

main().catch((error) => {
    console.error("An error occurred:", error);
    process.exit(1);
});