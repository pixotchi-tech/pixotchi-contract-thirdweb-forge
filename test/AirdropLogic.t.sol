// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/game/AirdropLogic.sol";
import "../src/nft/ERC721AExtension.sol";

contract MockERC721AExtension is ERC721AExtension {
    function setTokenOwnership(uint256 tokenId, bool burned) public {
        ERC721AStorage.Data storage data = ERC721AStorage.erc721AStorage();
        data._ownerships[tokenId].burned = burned;
    }

    function setCurrentIndex(uint256 index) public {
        ERC721AStorage.Data storage data = ERC721AStorage.erc721AStorage();
        data._currentIndex = index;
    }
}

// Modified AirdropLogic for testing
contract TestableAirdropLogic is AirdropLogic {
    function setPlantTimeUntilStarving(uint256 tokenId, uint256 time) public {
        GameStorage.data().plantTimeUntilStarving[tokenId] = time;
    }
}

contract AirdropLogicTest is Test {
    TestableAirdropLogic public airdropLogic;
    MockERC721AExtension public mockERC721A;

    function setUp() public {
        mockERC721A = new MockERC721AExtension();
        airdropLogic = new TestableAirdropLogic();

        // Setup mock storage access for ERC721A
        vm.etch(address(ERC721AStorage), address(mockERC721A).code);
    }

    function testAirdropGetAliveTokenIds() public {
        // Set up test data
        uint256 currentIndex = 5;
        mockERC721A.setCurrentIndex(currentIndex);

        // Token 0: Alive
        mockERC721A.setTokenOwnership(0, false);
        airdropLogic.setPlantTimeUntilStarving(0, block.timestamp + 1 hours);

        // Token 1: Burned
        mockERC721A.setTokenOwnership(1, true);

        // Token 2: Alive
        mockERC721A.setTokenOwnership(2, false);
        airdropLogic.setPlantTimeUntilStarving(2, block.timestamp + 2 hours);

        // Token 3: Starving
        mockERC721A.setTokenOwnership(3, false);
        airdropLogic.setPlantTimeUntilStarving(3, block.timestamp - 1 hours);

        // Token 4: Alive
        mockERC721A.setTokenOwnership(4, false);
        airdropLogic.setPlantTimeUntilStarving(4, block.timestamp + 3 hours);

        // Get alive token IDs
        uint256[] memory aliveTokenIds = airdropLogic.airdropGetAliveTokenIds();

        // Assert results
        assertEq(aliveTokenIds.length, 3, "Should return 3 alive tokens");
        assertEq(aliveTokenIds[0], 0, "First alive token should be 0");
        assertEq(aliveTokenIds[1], 2, "Second alive token should be 2");
        assertEq(aliveTokenIds[2], 4, "Third alive token should be 4");
    }

    function testAirdropGetAliveTokenIdsWithNoAliveTokens() public {
        uint256 currentIndex = 3;
        mockERC721A.setCurrentIndex(currentIndex);

        // All tokens are either burned or starving
        for (uint256 i = 0; i < currentIndex; i++) {
            mockERC721A.setTokenOwnership(i, i % 2 == 0); // Alternate between burned and not burned
            airdropLogic.setPlantTimeUntilStarving(i, block.timestamp - 1 hours);
        }

        uint256[] memory aliveTokenIds = airdropLogic.airdropGetAliveTokenIds();

        assertEq(aliveTokenIds.length, 0, "Should return no alive tokens");
    }

    function testAirdropGetAliveTokenIdsWithAllAliveTokens() public {
        uint256 currentIndex = 3;
        mockERC721A.setCurrentIndex(currentIndex);

        // All tokens are alive
        for (uint256 i = 0; i < currentIndex; i++) {
            mockERC721A.setTokenOwnership(i, false);
            airdropLogic.setPlantTimeUntilStarving(i, block.timestamp + 1 hours);
        }

        uint256[] memory aliveTokenIds = airdropLogic.airdropGetAliveTokenIds();

        assertEq(aliveTokenIds.length, currentIndex, "Should return all tokens as alive");
        for (uint256 i = 0; i < currentIndex; i++) {
            assertEq(aliveTokenIds[i], i, string(abi.encodePacked("Token ", uint2str(i), " should be alive")));
        }
    }

    // Helper function to convert uint to string
    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        j = _i;
        while (j != 0) {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        str = string(bstr);
    }
}