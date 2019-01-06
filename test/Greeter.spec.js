const Greeter = artifacts.require('Greeter');

contract('Greeter', async () => {
  let instance;
  const sampleUser = 'John';

  before(async () => {
    instance = await Greeter.deployed();
  })

  it('Should have a default greeting message with no name', async () => {
    const greeting = await instance.greetUser.call();
    assert.equal(greeting, 'Welcome NO NAME');
  })

  it('It should succesfully set the given username and update state', async () => {
    await instance.setName(sampleUser);
    const newGreeting = await instance.greetUser();
    assert.equal(newGreeting, `Welcome ${sampleUser}`);
  })
})