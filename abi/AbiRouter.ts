export const AbiRouter =  [
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
    }
] as const;