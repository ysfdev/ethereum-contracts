pragma solidity >=0.4.0 <0.6.0;

library ConcatLib {
    function concat(string memory a, string memory b)
            internal pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }
}
