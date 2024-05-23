// SPDX-License-Identifier: MIT
// @author: thirdweb (https://github.com/thirdweb-dev/dynamic-contracts)

pragma solidity ^0.8.0;

import "../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import "../../../extension/upgradeable/Initializable.sol";

/**
 *  This smart contract is an EXAMPLE, and is not meant for use in production.
 */
contract Pixotchi is
BaseRouter,
Initializable  {

    address public admin;

//    constructor() BaseRouter(new Extension[](0)) {
//        admin = msg.sender;
//    }
    /// @dev We accept constructor params as a struct to avoid `Stack too deep` errors.
    struct PixotchiConstructorParams {
        Extension[] extensions;
        address royaltyEngineAddress;
        address nativeTokenWrapper;
    }

    constructor(
        PixotchiConstructorParams memory _pV3Params
    ) BaseRouter(_pV3Params.extensions) {
        tokenAddress = _pV3Params.tokenAddress;
        //_disableInitializers();
    }

    // @dev Sets the admin address.
    function setAdmin(address _admin) external {
        require(msg.sender == admin, "RouterUpgradeable: Only admin can set a new admin");
        admin = _admin;
    }

    /*///////////////////////////////////////////////////////////////
                            Overrides
    //////////////////////////////////////////////////////////////*/

    /// @dev Returns whether a function can be disabled in an extension in the given execution context.
    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
        return msg.sender == admin;
    }
}
