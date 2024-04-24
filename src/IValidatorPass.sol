// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IValidatorPass {
    /// Get the validator address linked to a certain validator pass id.
    /// @param tokenId The id of the validator pass.
    /// @dev Bytes32(0) means there is no address linked.
    function getValidator(uint256 tokenId) external view returns (bytes32 validatorAddress);

    /// Enabling a certain validator address to join the network. This will disable any previously set validator address.
    /// @param tokenId The id of the validator pass.
    /// @param validatorAddress The address of the validator to activate.
    /// @notice A pass can only be transferred while it's validatorAddress is zero. You can set it to the zero bytes to disable your validator.
    function setValidator(uint256 tokenId, bytes32 validatorAddress) external;
}
