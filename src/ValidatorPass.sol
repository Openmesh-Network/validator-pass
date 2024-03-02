// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721, IERC721, IERC165} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "../lib/openzeppelin-contracts/contracts/access/AccessControl.sol";

import {OpenmeshENSReverseClaimable} from "../lib/openmesh-admin/src/OpenmeshENSReverseClaimable.sol";
import {IERC721Mintable} from "./IERC721Mintable.sol";

contract ValidatorPass is ERC721, AccessControl, OpenmeshENSReverseClaimable, IERC721Mintable {
    bytes32 public constant MINT_ROLE = keccak256("MINT");
    uint256 public mintCounter;

    error NotTransferable();

    constructor() ERC721("Genesis Validator Pass", "GVP") {
        _grantRole(DEFAULT_ADMIN_ROLE, OPENMESH_ADMIN);
    }

    /// @inheritdoc ERC721
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, AccessControl, IERC165)
        returns (bool)
    {
        return interfaceId == type(IERC721Mintable).interfaceId || ERC721.supportsInterface(interfaceId)
            || AccessControl.supportsInterface(interfaceId);
    }

    /// @inheritdoc IERC721Mintable
    function mint(address account) external onlyRole(MINT_ROLE) {
        _mint(account, mintCounter++);
    }

    /// @inheritdoc ERC721
    function transferFrom(address from, address to, uint256 tokenId) public pure override(ERC721, IERC721) {
        revert NotTransferable();
    }

    /// @inheritdoc ERC721
    function _baseURI() internal view override returns (string memory) {
        return "https://erc721.openmesh.network/metadata/gvp/";
    }
}
