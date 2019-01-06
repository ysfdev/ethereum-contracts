const ScoreTracker = artifacts.require('ScoreTracker');
const {catchRevert} = require('./exceptions');

contract('ScoreTracker', async () => {
  let instance;
  const testUser = "Jay";
  const testScore = 94;

  before(async () => {
    instance = await ScoreTracker.deployed();
  })

  it('Should record given name score to storage', async () => {
    await instance.addScore(testUser, testScore);
    const recordedScore = await instance.getScore(testUser);
    assert.equal(recordedScore.toNumber(), testScore);
  })

  it('Should revert when attempting to add existing recorded named score', async () => {
    await catchRevert(instance.addScore(testUser, testScore));
  })
})