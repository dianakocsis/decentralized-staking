import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const deployStaker: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy, get } = hre.deployments;
  const exampleExternalContract = await get("ExampleExternalContract");

  await deploy("Staker", {
    from: deployer,
    // Contract constructor arguments
    args: [exampleExternalContract.address],
    log: true,
    autoMine: true,
  });
};

export default deployStaker;

deployStaker.tags = ["Staker"];
