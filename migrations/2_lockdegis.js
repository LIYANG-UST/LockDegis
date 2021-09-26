const LockDegis = artifacts.require("LockDegis");
const DegisToken = "";

module.exports = function (deployer) {
  deployer.deploy(LockDegis, DegisToken);
};
