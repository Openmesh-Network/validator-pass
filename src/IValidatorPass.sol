// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IValidatorPass {
    /// Get the validator address linked to a certain validator pass id.
    /// @param tokenId The id of the validator pass.
    /// @dev Bytes32(0) means there is no address linked.
    function getValidator(uint256 tokenId) external view returns (bytes32 validatorAddress);

    /// Redeem the validator pass, enabling a certain validator address to join the network.
    /// @param tokenId The id of the validator pass.
    /// @param validatorAddress The address of the validator to activate.
    /// @notice A pass can only be redeemed once. After being redeemed it cannot be transfered anymore.
    function redeem(uint256 tokenId, bytes32 validatorAddress) external;
}
