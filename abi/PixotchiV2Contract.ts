import { getAddress } from "viem";

export const PixotchiV2Abi = [
  {
    "type": "function",
    "name": "balanceOf",
    "inputs": [
      {
        "name": "tokenOwner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "balance",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "totalSupply",
    "inputs": [],
    "outputs": [
      {
        "name": "supply",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "transfer",
    "inputs": [
      {
        "name": "to",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "tokens",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "success",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "transferFrom",
    "inputs": [
      {
        "name": "from",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "to",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "tokens",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "success",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "constructor",
    "inputs": [
      {
        "name": "_simpleRouterV3Params",
        "type": "tuple",
        "internalType": "struct PixotchiRouter.SimpleRouterConstructorParams",
        "components": [
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IExtension.Extension[]",
            "components": [
              {
                "name": "metadata",
                "type": "tuple",
                "internalType": "struct IExtension.ExtensionMetadata",
                "components": [
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "metadataURI",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "implementation",
                    "type": "address",
                    "internalType": "address"
                  }
                ]
              },
              {
                "name": "functions",
                "type": "tuple[]",
                "internalType": "struct IExtension.ExtensionFunction[]",
                "components": [
                  {
                    "name": "functionSelector",
                    "type": "bytes4",
                    "internalType": "bytes4"
                  },
                  {
                    "name": "functionSignature",
                    "type": "string",
                    "internalType": "string"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "fallback",
    "stateMutability": "payable"
  },
  {
    "type": "receive",
    "stateMutability": "payable"
  },
  {
    "type": "function",
    "name": "DEFAULT_ADMIN_ROLE",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "bytes32",
        "internalType": "bytes32"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "_disableFunctionInExtension",
    "inputs": [
      {
        "name": "_extensionName",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "_functionSelector",
        "type": "bytes4",
        "internalType": "bytes4"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "addExtension",
    "inputs": [
      {
        "name": "_extension",
        "type": "tuple",
        "internalType": "struct IExtension.Extension",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "contractType",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "bytes32",
        "internalType": "bytes32"
      }
    ],
    "stateMutability": "pure"
  },
  {
    "type": "function",
    "name": "contractVersion",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "uint8",
        "internalType": "uint8"
      }
    ],
    "stateMutability": "pure"
  },
  {
    "type": "function",
    "name": "defaultExtensions",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "address",
        "internalType": "address"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "disableFunctionInExtension",
    "inputs": [
      {
        "name": "_extensionName",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "_functionSelector",
        "type": "bytes4",
        "internalType": "bytes4"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "enableFunctionInExtension",
    "inputs": [
      {
        "name": "_extensionName",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "_function",
        "type": "tuple",
        "internalType": "struct IExtension.ExtensionFunction",
        "components": [
          {
            "name": "functionSelector",
            "type": "bytes4",
            "internalType": "bytes4"
          },
          {
            "name": "functionSignature",
            "type": "string",
            "internalType": "string"
          }
        ]
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "getAllExtensions",
    "inputs": [],
    "outputs": [
      {
        "name": "allExtensions",
        "type": "tuple[]",
        "internalType": "struct IExtension.Extension[]",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getExtension",
    "inputs": [
      {
        "name": "extensionName",
        "type": "string",
        "internalType": "string"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple",
        "internalType": "struct IExtension.Extension",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getImplementationForFunction",
    "inputs": [
      {
        "name": "_functionSelector",
        "type": "bytes4",
        "internalType": "bytes4"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "address",
        "internalType": "address"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getMetadataForFunction",
    "inputs": [
      {
        "name": "functionSelector",
        "type": "bytes4",
        "internalType": "bytes4"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple",
        "internalType": "struct IExtension.ExtensionMetadata",
        "components": [
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "metadataURI",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "implementation",
            "type": "address",
            "internalType": "address"
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getRoleAdmin",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bytes32",
        "internalType": "bytes32"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getRoleMember",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      },
      {
        "name": "index",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "member",
        "type": "address",
        "internalType": "address"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getRoleMemberCount",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      }
    ],
    "outputs": [
      {
        "name": "count",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "grantRole",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "hasRole",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "hasRoleWithSwitch",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "initializeRouter",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "isTrustedForwarder",
    "inputs": [
      {
        "name": "forwarder",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "removeExtension",
    "inputs": [
      {
        "name": "_extensionName",
        "type": "string",
        "internalType": "string"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "renounceRole",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "replaceExtension",
    "inputs": [
      {
        "name": "_extension",
        "type": "tuple",
        "internalType": "struct IExtension.Extension",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "revokeRole",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "ExtensionAdded",
    "inputs": [
      {
        "name": "name",
        "type": "string",
        "indexed": true,
        "internalType": "string"
      },
      {
        "name": "implementation",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "extension",
        "type": "tuple",
        "indexed": false,
        "internalType": "struct IExtension.Extension",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ExtensionRemoved",
    "inputs": [
      {
        "name": "name",
        "type": "string",
        "indexed": true,
        "internalType": "string"
      },
      {
        "name": "extension",
        "type": "tuple",
        "indexed": false,
        "internalType": "struct IExtension.Extension",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ExtensionReplaced",
    "inputs": [
      {
        "name": "name",
        "type": "string",
        "indexed": true,
        "internalType": "string"
      },
      {
        "name": "implementation",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "extension",
        "type": "tuple",
        "indexed": false,
        "internalType": "struct IExtension.Extension",
        "components": [
          {
            "name": "metadata",
            "type": "tuple",
            "internalType": "struct IExtension.ExtensionMetadata",
            "components": [
              {
                "name": "name",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "metadataURI",
                "type": "string",
                "internalType": "string"
              },
              {
                "name": "implementation",
                "type": "address",
                "internalType": "address"
              }
            ]
          },
          {
            "name": "functions",
            "type": "tuple[]",
            "internalType": "struct IExtension.ExtensionFunction[]",
            "components": [
              {
                "name": "functionSelector",
                "type": "bytes4",
                "internalType": "bytes4"
              },
              {
                "name": "functionSignature",
                "type": "string",
                "internalType": "string"
              }
            ]
          }
        ]
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "FunctionDisabled",
    "inputs": [
      {
        "name": "name",
        "type": "string",
        "indexed": true,
        "internalType": "string"
      },
      {
        "name": "functionSelector",
        "type": "bytes4",
        "indexed": true,
        "internalType": "bytes4"
      },
      {
        "name": "extMetadata",
        "type": "tuple",
        "indexed": false,
        "internalType": "struct IExtension.ExtensionMetadata",
        "components": [
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "metadataURI",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "implementation",
            "type": "address",
            "internalType": "address"
          }
        ]
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "FunctionEnabled",
    "inputs": [
      {
        "name": "name",
        "type": "string",
        "indexed": true,
        "internalType": "string"
      },
      {
        "name": "functionSelector",
        "type": "bytes4",
        "indexed": true,
        "internalType": "bytes4"
      },
      {
        "name": "extFunction",
        "type": "tuple",
        "indexed": false,
        "internalType": "struct IExtension.ExtensionFunction",
        "components": [
          {
            "name": "functionSelector",
            "type": "bytes4",
            "internalType": "bytes4"
          },
          {
            "name": "functionSignature",
            "type": "string",
            "internalType": "string"
          }
        ]
      },
      {
        "name": "extMetadata",
        "type": "tuple",
        "indexed": false,
        "internalType": "struct IExtension.ExtensionMetadata",
        "components": [
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "metadataURI",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "implementation",
            "type": "address",
            "internalType": "address"
          }
        ]
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "RoleAdminChanged",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "indexed": true,
        "internalType": "bytes32"
      },
      {
        "name": "previousAdminRole",
        "type": "bytes32",
        "indexed": true,
        "internalType": "bytes32"
      },
      {
        "name": "newAdminRole",
        "type": "bytes32",
        "indexed": true,
        "internalType": "bytes32"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "RoleGranted",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "indexed": true,
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "sender",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "RoleRevoked",
    "inputs": [
      {
        "name": "role",
        "type": "bytes32",
        "indexed": true,
        "internalType": "bytes32"
      },
      {
        "name": "account",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "sender",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      }
    ],
    "anonymous": false
  },
  {
    "type": "error",
    "name": "InvalidCodeAtRange",
    "inputs": [
      {
        "name": "_size",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_start",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_end",
        "type": "uint256",
        "internalType": "uint256"
      }
    ]
  },
  {
    "type": "error",
    "name": "WriteError",
    "inputs": []
  },
  {
    "type": "function",
    "name": "initializeConfigLogic",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setConfig",
    "inputs": [
      {
        "name": "_mintIsActive",
        "type": "bool",
        "internalType": "bool"
      },
      {
        "name": "_burnPercentage",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setPRECISION",
    "inputs": [
      {
        "name": "_precision",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setRenderer",
    "inputs": [
      {
        "name": "_renderer",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setRevShareWallet",
    "inputs": [
      {
        "name": "_revShareWallet",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setStrain",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "mintPrice",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "maxSupply",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "name",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "ipfsHash",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "isActive",
        "type": "bool",
        "internalType": "bool"
      },
      {
        "name": "strainInitialTOD",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "strainCounter",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setToken",
    "inputs": [
      {
        "name": "_token",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "function",
    "name": "debugGetBurnedPlants",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "debugGetIdsByOwner",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint32[]",
        "internalType": "uint32[]"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "debugGetIdsByOwnerLength",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "debugGetOwnerIndexById",
    "inputs": [
      {
        "name": "id",
        "type": "uint32",
        "internalType": "uint32"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint32",
        "internalType": "uint32"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "debugSetBurnedPlants",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "burned",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "debugSetIdsByOwner",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "ids",
        "type": "uint32[]",
        "internalType": "uint32[]"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "debugSetOwnerIndexById",
    "inputs": [
      {
        "name": "id",
        "type": "uint32",
        "internalType": "uint32"
      },
      {
        "name": "index",
        "type": "uint32",
        "internalType": "uint32"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "removeDuplicateTokenIds",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "DuplicateTokenIdsRemoved",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "beforeIdsLength",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "afterIdsLength",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "function",
    "name": "attack",
    "inputs": [
      {
        "name": "fromId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "toId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "getAllStrainInfo",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGame.Strain[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "mintPrice",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "totalSupply",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "totalMinted",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "maxSupply",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "isActive",
            "type": "bool",
            "internalType": "bool"
          },
          {
            "name": "getStrainTotalLeft",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strainInitialTOD",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantName",
    "inputs": [
      {
        "name": "_id",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getStatus",
    "inputs": [
      {
        "name": "plant",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint8",
        "internalType": "enum IGame.Status"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "isApprovedFn",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "wallet",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "isPlantAlive",
    "inputs": [
      {
        "name": "_nftId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "kill",
    "inputs": [
      {
        "name": "_deadId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "level",
    "inputs": [
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "onAttack",
    "inputs": [
      {
        "name": "fromId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "toId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "pct",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "odds",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "canAttack",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "pass",
    "inputs": [
      {
        "name": "from",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "to",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "pendingEth",
    "inputs": [
      {
        "name": "plantId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "redeem",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setPlantName",
    "inputs": [
      {
        "name": "_id",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_name",
        "type": "string",
        "internalType": "string"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "statusToString",
    "inputs": [
      {
        "name": "status",
        "type": "uint8",
        "internalType": "enum IGame.Status"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "pure"
  },
  {
    "type": "event",
    "name": "Attack",
    "inputs": [
      {
        "name": "attacker",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "winner",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "loser",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "scoresWon",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Killed",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "deadId",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "loserName",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      },
      {
        "name": "reward",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "killer",
        "type": "address",
        "indexed": false,
        "internalType": "address"
      },
      {
        "name": "winnerName",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Pass",
    "inputs": [
      {
        "name": "from",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "to",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "RedeemRewards",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      },
      {
        "name": "reward",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "function",
    "name": "buyAccessory",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "createItem",
    "inputs": [
      {
        "name": "name",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "price",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "points",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "timeExtension",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "createItems",
    "inputs": [
      {
        "name": "items",
        "type": "tuple[]",
        "internalType": "struct IGarden.FullItem[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "price",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "points",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timeExtension",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "editGardenItems",
    "inputs": [
      {
        "name": "updates",
        "type": "tuple[]",
        "internalType": "struct IGarden.FullItem[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "price",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "points",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timeExtension",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "editItem",
    "inputs": [
      {
        "name": "_id",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_price",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_points",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_name",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "_timeExtension",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "getAllGardenItem",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGarden.FullItem[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "price",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "points",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timeExtension",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getGardenItem",
    "inputs": [
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple",
        "internalType": "struct IGarden.FullItem",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "price",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "points",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timeExtension",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "initializeGardenLogic",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "itemExists",
    "inputs": [
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ItemConsumed",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "giver",
        "type": "address",
        "indexed": false,
        "internalType": "address"
      },
      {
        "name": "itemId",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ItemCreated",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "name",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      },
      {
        "name": "price",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "points",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "function",
    "name": "boxGameGetCoolDownTimePerNFT",
    "inputs": [
      {
        "name": "nftID",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "boxGameInitialize",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "boxGamePlay",
    "inputs": [
      {
        "name": "nftID",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "seed",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "points",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "timeExtension",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "boxGameSetGlobalCoolDownTime",
    "inputs": [
      {
        "name": "_coolDownTime",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "boxGameSetPointRewards",
    "inputs": [
      {
        "name": "_pointRewards",
        "type": "uint256[5]",
        "internalType": "uint256[5]"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "boxGameSetTimeRewards",
    "inputs": [
      {
        "name": "_timeRewards",
        "type": "uint256[5]",
        "internalType": "uint256[5]"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Played",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      },
      {
        "name": "points",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "timeExtension",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "gameName",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "PlayedV2",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      },
      {
        "name": "points",
        "type": "int256",
        "indexed": false,
        "internalType": "int256"
      },
      {
        "name": "timeExtension",
        "type": "int256",
        "indexed": false,
        "internalType": "int256"
      },
      {
        "name": "gameName",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      }
    ],
    "anonymous": false
  },
  {
    "type": "function",
    "name": "SpinGameInitialize",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "spinGameGetCoolDownTimePerNFT",
    "inputs": [
      {
        "name": "nftID",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "spinGamePlay",
    "inputs": [
      {
        "name": "nftID",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "seed",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "pointsAdjustment",
        "type": "int256",
        "internalType": "int256"
      },
      {
        "name": "timeAdjustment",
        "type": "int256",
        "internalType": "int256"
      },
      {
        "name": "isPercentage",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "spinGameSetCoolDownTime",
    "inputs": [
      {
        "name": "_coolDownTime",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "spinGameSetIsPercentage",
    "inputs": [
      {
        "name": "_isPercentage",
        "type": "bool[]",
        "internalType": "bool[]"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "spinGameSetPointRewards",
    "inputs": [
      {
        "name": "_pointRewards",
        "type": "uint256[]",
        "internalType": "uint256[]"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "spinGameSetTimeRewards",
    "inputs": [
      {
        "name": "_timeRewards",
        "type": "int256[]",
        "internalType": "int256[]"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Played",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      },
      {
        "name": "points",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "timeExtension",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "gameName",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "PlayedV2",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      },
      {
        "name": "points",
        "type": "int256",
        "indexed": false,
        "internalType": "int256"
      },
      {
        "name": "timeExtension",
        "type": "int256",
        "indexed": false,
        "internalType": "int256"
      },
      {
        "name": "gameName",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      }
    ],
    "anonymous": false
  },
  {
    "type": "function",
    "name": "isBurned",
    "inputs": [
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "_getPlantsByOwner",
    "inputs": [
      {
        "name": "_owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGame.PlantFull[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "approve",
    "inputs": [
      {
        "name": "to",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "balanceOf",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "burn",
    "inputs": [
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "getApproved",
    "inputs": [
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "address",
        "internalType": "address"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantInfo",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple",
        "internalType": "struct IGame.PlantFull",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantInfoExtended",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple",
        "internalType": "struct IGame.PlantFull",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantScore",
    "inputs": [
      {
        "name": "plantId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantTimeUntilStarving",
    "inputs": [
      {
        "name": "plantId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantsByOwner",
    "inputs": [
      {
        "name": "_owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGame.PlantFull[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantsByOwnerExtended",
    "inputs": [
      {
        "name": "_owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGame.PlantFull[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantsInfo",
    "inputs": [
      {
        "name": "_nftIds",
        "type": "uint256[]",
        "internalType": "uint256[]"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGame.PlantFull[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "getPlantsInfoExtended",
    "inputs": [
      {
        "name": "_nftIds",
        "type": "uint256[]",
        "internalType": "uint256[]"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IGame.PlantFull[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "initializeNFTLogic",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "isApprovedForAll",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "operator",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "mint",
    "inputs": [
      {
        "name": "strain",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "name",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "ownerOf",
    "inputs": [
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "address",
        "internalType": "address"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "removeTokenIdFromOwner",
    "inputs": [
      {
        "name": "tokenId",
        "type": "uint32",
        "internalType": "uint32"
      },
      {
        "name": "owner",
        "type": "address",
        "internalType": "address"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "safeTransferFrom",
    "inputs": [
      {
        "name": "from",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "to",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "safeTransferFrom",
    "inputs": [
      {
        "name": "from",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "to",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "_data",
        "type": "bytes",
        "internalType": "bytes"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "setApprovalForAll",
    "inputs": [
      {
        "name": "operator",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "approved",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "supportsInterface",
    "inputs": [
      {
        "name": "interfaceId",
        "type": "bytes4",
        "internalType": "bytes4"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "symbol",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "tokenBurnAndRedistribute",
    "inputs": [
      {
        "name": "account",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "amount",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "tokenURI",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "totalSupply",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "transferFrom",
    "inputs": [
      {
        "name": "from",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "to",
        "type": "address",
        "internalType": "address"
      },
      {
        "name": "tokenId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "Approval",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "approved",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "tokenId",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ApprovalForAll",
    "inputs": [
      {
        "name": "owner",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "operator",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "approved",
        "type": "bool",
        "indexed": false,
        "internalType": "bool"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Mint",
    "inputs": [
      {
        "name": "to",
        "type": "address",
        "indexed": false,
        "internalType": "address"
      },
      {
        "name": "strain",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "id",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "Transfer",
    "inputs": [
      {
        "name": "from",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "to",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "tokenId",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "error",
    "name": "ApprovalCallerNotOwnerNorApproved",
    "inputs": []
  },
  {
    "type": "error",
    "name": "ApprovalQueryForNonexistentToken",
    "inputs": []
  },
  {
    "type": "error",
    "name": "ApprovalToCurrentOwner",
    "inputs": []
  },
  {
    "type": "error",
    "name": "ApproveToCaller",
    "inputs": []
  },
  {
    "type": "error",
    "name": "BalanceQueryForZeroAddress",
    "inputs": []
  },
  {
    "type": "error",
    "name": "MintToZeroAddress",
    "inputs": []
  },
  {
    "type": "error",
    "name": "MintZeroQuantity",
    "inputs": []
  },
  {
    "type": "error",
    "name": "OwnerQueryForNonexistentToken",
    "inputs": []
  },
  {
    "type": "error",
    "name": "TransferCallerNotOwnerNorApproved",
    "inputs": []
  },
  {
    "type": "error",
    "name": "TransferFromIncorrectOwner",
    "inputs": []
  },
  {
    "type": "error",
    "name": "TransferToNonERC721ReceiverImplementer",
    "inputs": []
  },
  {
    "type": "error",
    "name": "TransferToZeroAddress",
    "inputs": []
  },
  {
    "type": "error",
    "name": "URIQueryForNonexistentToken",
    "inputs": []
  },
  {
    "type": "constructor",
    "inputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "getImageUri",
    "inputs": [
      {
        "name": "_level",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "ipfsHash",
        "type": "string",
        "internalType": "string"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "pure"
  },
  {
    "type": "function",
    "name": "prepareTokenURI",
    "inputs": [
      {
        "name": "plant",
        "type": "tuple",
        "internalType": "struct IGame.PlantFull",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "timeUntilStarving",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "score",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "timePlantBorn",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttackUsed",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "lastAttacked",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "stars",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "strain",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "status",
            "type": "uint8",
            "internalType": "enum IGame.Status"
          },
          {
            "name": "statusStr",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "level",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "owner",
            "type": "address",
            "internalType": "address"
          },
          {
            "name": "rewards",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "extensions",
            "type": "tuple[]",
            "internalType": "struct IGameExtensions.PlantExtensions[]",
            "components": [
              {
                "name": "shopItemOwned",
                "type": "tuple[]",
                "internalType": "struct IShop.ShopItemOwned[]",
                "components": [
                  {
                    "name": "id",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "name",
                    "type": "string",
                    "internalType": "string"
                  },
                  {
                    "name": "effectUntil",
                    "type": "uint256",
                    "internalType": "uint256"
                  },
                  {
                    "name": "effectIsOngoingActive",
                    "type": "bool",
                    "internalType": "bool"
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "name": "ipfsHash",
        "type": "string",
        "internalType": "string"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "string",
        "internalType": "string"
      }
    ],
    "stateMutability": "pure"
  },
  {
    "type": "function",
    "name": "reinitializer_8_ShopLogic",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "shopBuyItem",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "shopDoesItemExist",
    "inputs": [
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "shopGetAllItems",
    "inputs": [],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IShop.ShopItem[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "price",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "effectTime",
            "type": "uint256",
            "internalType": "uint256"
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "shopGetPurchasedItems",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "tuple[]",
        "internalType": "struct IShop.ShopItemOwned[]",
        "components": [
          {
            "name": "id",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "name",
            "type": "string",
            "internalType": "string"
          },
          {
            "name": "effectUntil",
            "type": "uint256",
            "internalType": "uint256"
          },
          {
            "name": "effectIsOngoingActive",
            "type": "bool",
            "internalType": "bool"
          }
        ]
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "shopIsEffectOngoing",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [
      {
        "name": "",
        "type": "bool",
        "internalType": "bool"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "shopModifyItem",
    "inputs": [
      {
        "name": "itemId",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "name",
        "type": "string",
        "internalType": "string"
      },
      {
        "name": "price",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "expireTime",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "maxSupply",
        "type": "uint256",
        "internalType": "uint256"
      },
      {
        "name": "effectTime",
        "type": "uint256",
        "internalType": "uint256"
      }
    ],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "event",
    "name": "Initialized",
    "inputs": [
      {
        "name": "version",
        "type": "uint8",
        "indexed": false,
        "internalType": "uint8"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ShopItemCreated",
    "inputs": [
      {
        "name": "id",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "name",
        "type": "string",
        "indexed": false,
        "internalType": "string"
      },
      {
        "name": "price",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      },
      {
        "name": "expireTime",
        "type": "uint256",
        "indexed": false,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  },
  {
    "type": "event",
    "name": "ShopItemPurchased",
    "inputs": [
      {
        "name": "nftId",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      },
      {
        "name": "buyer",
        "type": "address",
        "indexed": true,
        "internalType": "address"
      },
      {
        "name": "itemId",
        "type": "uint256",
        "indexed": true,
        "internalType": "uint256"
      }
    ],
    "anonymous": false
  }
] as const;

export const PixotchiV2Contract = {
    address: getAddress(process.env.PIXOTCHI_NFT_CONTRACT_ADDRESS_V2!),
    abi: PixotchiV2Abi,
} as const;