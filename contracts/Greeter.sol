pragma solidity >=0.4.0 <0.6.0;

import "./ConcatLib.sol";

contract Greeter {
    string private greetingPrefix;
    string public userName;
    
    //Constructor 
    constructor() public {
        greetingPrefix = "Welcome ";
        userName = "NO NAME";
    }
    
    function setName(string memory name) public {
        userName = name;
    }
    
    function greetUser() public  view returns (string memory greetingMsg_) {
        greetingMsg_ = ConcatLib.concat(greetingPrefix, userName);
        return greetingMsg_;
    }
}