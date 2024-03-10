import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeployValidatorPassSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deployValidatorPass(
  deployer: Deployer,
  settings: DeployValidatorPassSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "Validator Pass",
      contract: "ValidatorPass",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
