pragma solidity >=0.4.0 <0.6.0;

contract ScoreTracker {
    mapping(string => int) ScoresRecorded;

    function addScore(string memory name, int score) public {
        //Check if already exists 
        if (ScoresRecorded[name]>0) {
            // revert the transaction, because we should only have uniquely identifed scores keys
            revert("Score with provided name was already recorded.");
        }

        ScoresRecorded[name] = score;
    }

    function getScore(string memory name) public view returns (int) {
        return ScoresRecorded[name];
    }
}