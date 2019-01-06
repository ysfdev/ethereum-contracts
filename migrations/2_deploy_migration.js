var ConcatLib = artifacts.require("./ConcatLib.sol");
var Greeter = artifacts.require("./Greeter.sol");
var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var ScoreTracker = artifacts.require("./ScoreTracker.sol");

module.exports = function(deployer) {
  deployer.deploy(ConcatLib);
  deployer.deploy(Greeter);
  deployer.deploy(SimpleStorage);
  deployer.deploy(ScoreTracker);
};