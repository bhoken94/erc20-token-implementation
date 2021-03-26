const AleToken = artifacts.require('AleToken');
const AleToken2 = artifacts.require('AleToken2');

module.exports = function (deployer) {
  deployer.deploy(AleToken2, 1000);
  deployer.deploy(AleToken, 1000);
};
