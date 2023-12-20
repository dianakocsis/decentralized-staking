import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const deployExampleExternalContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  await deploy("ExampleExternalContract", {
    from: deployer,
    log: true,
    autoMine: true,
  });
};

export default deployExampleExternalContract;

deployExampleExternalContract.tags = ["ExampleExternalContract"];
