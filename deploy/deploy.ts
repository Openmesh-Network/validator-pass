import { Address, Deployer } from "../web3webdeploy/types";
import {
  DeployValidatorPassSettings,
  deployValidatorPass,
} from "./internal/ValidatorPass";

export interface ValidatorPassDeploymentSettings {
  validatorPassSettings: DeployValidatorPassSettings;
  forceRedeploy?: boolean;
}

export interface ValidatorPassDeployment {
  validatorPass: Address;
}

export async function deploy(
  deployer: Deployer,
  settings?: ValidatorPassDeploymentSettings
): Promise<ValidatorPassDeployment> {
  if (settings?.forceRedeploy !== undefined && !settings.forceRedeploy) {
    const existingDeployment = await deployer.loadDeployment({
      deploymentName: "latest.json",
    });
    if (existingDeployment !== undefined) {
      return existingDeployment;
    }
  }

  const validatorPass = await deployValidatorPass(
    deployer,
    settings?.validatorPassSettings ?? {}
  );

  const deployment: ValidatorPassDeployment = {
    validatorPass: validatorPass,
  };
  await deployer.saveDeployment({
    deploymentName: "latest.json",
    deployment: deployment,
  });
  return deployment;
}
