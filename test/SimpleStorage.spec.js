const SimpleStorage = artifacts.require('SimpleStorage');

contract('SimpleStorage', async () => {
  let instance;

  before(async () => {
    instance = await SimpleStorage.deployed();
  })

  it('Initial value shoud be 0', async () => {
    const value = await instance.get();
    assert.equal(value.toNumber(), 0);
  })

  it('Should increment storage by given value', async () => {
    const newStorageVal = 340;
    await instance.increment(newStorageVal);
    const newValue = await instance.get.call();
    assert.equal(newValue.toNumber(), newStorageVal)
  })

  it('Should set and decrement storage by given value', async () => {
    const newStorageVal = 30;
    await instance.set(300);
    await instance.decrement(newStorageVal);
    const newValue = await instance.get.call();
    assert.equal(newValue.toNumber(), 270)
  })
})