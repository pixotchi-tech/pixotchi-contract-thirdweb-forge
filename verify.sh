#!/bin/bash

# Load environment variables from .env file
source .env



# Construct the verifier URL from the virtual testnet RPC URL
TENDERLY_VERIFIER_URL="${TENDERLY_VIRTUAL_TESTNET_RPC_URL}/verify/etherscan"

# Declare a list with contract details
contracts=(
  "0xf21b77A11EBf063Af1623CB7C1a47a69832dDF1C:ERC721AExtension:false"
  "0xc8ca2e5357a2db307a2c9724756cd7204a22515b:NFTLogic:false"
  "0x0a1dded52a6b79b9d6052727303243c76f5e921b:GameLogic:false"
  "0x0BE35F4Dd448AEfab21b9C09c4BEb3978bAc920D:DebugLogic:false"
)

# Loop through each contract and verify if the flag is true
for contract in "${contracts[@]}"; do
  IFS=":" read -r CONTRACT_ADDRESS CONTRACT_NAME VERIFY_FLAG <<< "$contract"

  if [ "$VERIFY_FLAG" = true ]; then
    forge verify-contract $CONTRACT_ADDRESS  \
    $CONTRACT_NAME \
    --etherscan-api-key $TENDERLY_ACCESS_KEY \
    --verifier-url $TENDERLY_VERIFIER_URL \
    --watch
  else
    echo "Skipping verification for $CONTRACT_NAME at $CONTRACT_ADDRESS"
  fi
done
