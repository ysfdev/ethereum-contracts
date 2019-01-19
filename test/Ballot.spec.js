const Ballot = artifacts.require('Ballot');

contract('Ballot', async () => {
  let instance; 
  before(async () => {
    instance = await Ballot.deployed();
  })

  it('Should have deployed instance', async () => {
    assert.not.equal(instance, undefined);
  })

  // TODO: add other tests
})