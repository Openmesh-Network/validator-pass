import { Address, DeployInfo, Deployer } from "../web3webdeploy/types";

export interface ValidatorPassDeploymentSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export interface ValidatorPassDeployment {
  validatorPass: Address;
}

export async function deploy(
  deployer: Deployer,
  settings?: ValidatorPassDeploymentSettings
): Promise<ValidatorPassDeployment> {
  const validatorPass = await deployer.deploy({
    id: "Validator Pass",
    contract: "ValidatorPass",
    ...settings,
  });

  return {
    validatorPass: validatorPass,
  };
}
