pragma solidity >=0.4.0 <0.6.0;

contract Ballot {

  struct Voter {
	uint weight;
    bool voted;
    uint8 vote;
  }

  struct Proposal {
    uint voteCount;
  }

  enum Stage {Init, Reg, Vote, Done}
  Stage public stage = Stage.Init;

  address chairperson;
  mapping(address => Voter) voters;
  Proposal[] proposals;

  uint startTime;

  // initialize the Ballot with the given total of proposals for the campaign Ballot
  constructor(uint8 _numProposals) public {
    // The creator of Ballot its the chairperson, which higher voting weight/ for testing purposes
    chairperson = msg.sender;
    voters[chairperson].weight = 2; 
    proposals.length = _numProposals;
    // set the new stage Reg(Registration)
    // so we can start receiving new registeree
    stage = Stage.Reg;
    // for testing purposes we will rely on now = block.timestamp;
    // for official version, we should receive the specific deadlines timestamps on the Constructor
    startTime = now; 
  }

  // Register given voter (${toVoter}) to this ballot, so it has right to vote;
  // NOTE: Registration can only done by the chairperson
  function register(address toVoter) public {
    // Verify the ballot it's ready to accept registrations
    require(stage == Stage.Reg, "Ballot is not ready to accept registrations.");
    // Only continue, if sender if chairperson and given voter has not already voted
    if (msg.sender != chairperson || voters[toVoter].voted) revert("Sender is not authorized to register or given voter has already voted.");
    // all regular voters has a default voting weight of 1;
    voters[toVoter].weight = 1;
    voters[toVoter].voted = false;

    // for testing purposes; we curently update the stage to Vote after 60 seconds
    if (now > (startTime+ 60 seconds)) {
      stage = Stage.Vote;
      startTime = now;
    }
  }

 // Give a single vote to given ${toPrososal}
  function vote(uint8 toProposal) public {
    require(stage == Stage.Vote, "Ballot is not ready to accept votes.");
    Voter storage sender = voters[msg.sender];
    if (sender.voted || toProposal >= proposals.length) revert("Sender already voted or given proposals number is not valid.");
    sender.voted = true;
    proposals[toProposal].voteCount += sender.weight;

    if (now > (startTime+ 60 seconds)) {
      stage = Stage.Done;
    }
  }

  // Calculate and return the proposal with the highest voteCount
  function winningProposal() public view returns (uint8 _winningProposal) {
    require(stage == Stage.Done, "Ballot has not completed to determine winning proposal.");
    uint256 winningVoteCount = 0;
    for (uint8 prop = 0; prop < proposals.length; prop++) {
      if (proposals[prop].voteCount > winningVoteCount) {
        winningVoteCount = proposals[prop].voteCount;
        _winningProposal = prop;
      }
    }
  }
}