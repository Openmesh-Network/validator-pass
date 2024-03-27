// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721, IERC721, IERC165} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "../lib/openzeppelin-contracts/contracts/access/AccessControl.sol";

import {OpenmeshENSReverseClaimable} from "../lib/openmesh-admin/src/OpenmeshENSReverseClaimable.sol";
import {IERC721Mintable} from "./IERC721Mintable.sol";
import {IValidatorPass} from "./IValidatorPass.sol";

contract ValidatorPass is ERC721, AccessControl, OpenmeshENSReverseClaimable, IERC721Mintable, IValidatorPass {
    event Redeemed(uint256 tokenId, bytes32 validatorAddress);

    error InvalidValidatorAddress(bytes32 validatorAddress);
    error NotOwner(address account, uint256 tokenId);
    error AlreadyRedeemed(uint256 tokenId);

    bytes32 public constant MINT_ROLE = keccak256("MINT");
    uint256 public mintCounter;
    mapping(uint256 tokenId => bytes32 validatorAddress) private redeems;

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
        return interfaceId == type(IValidatorPass).interfaceId || interfaceId == type(IERC721Mintable).interfaceId
            || ERC721.supportsInterface(interfaceId) || AccessControl.supportsInterface(interfaceId);
    }

    /// @inheritdoc IValidatorPass
    function getValidator(uint256 tokenId) external view returns (bytes32 validatorAddress) {
        validatorAddress = redeems[tokenId];
    }

    /// @inheritdoc IERC721Mintable
    function mint(address account) external onlyRole(MINT_ROLE) {
        _mint(account, mintCounter++);
    }

    /// @inheritdoc IValidatorPass
    function redeem(uint256 tokenId, bytes32 validatorAddress) external {
        if (validatorAddress == bytes32(0)) {
            revert InvalidValidatorAddress(validatorAddress);
        }

        if (redeems[tokenId] != bytes32(0)) {
            revert AlreadyRedeemed(tokenId);
        }

        if (msg.sender != _ownerOf(tokenId)) {
            revert NotOwner(msg.sender, tokenId);
        }

        redeems[tokenId] = validatorAddress;
        emit Redeemed(tokenId, validatorAddress);
    }

    /// @inheritdoc ERC721
    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        if (redeems[tokenId] != bytes32(0)) {
            revert AlreadyRedeemed(tokenId);
        }

        super.transferFrom(from, to, tokenId);
    }

    /// @inheritdoc ERC721
    function _baseURI() internal pure override returns (string memory) {
        return "https://erc721.openmesh.network/metadata/gvp/";
    }
}
