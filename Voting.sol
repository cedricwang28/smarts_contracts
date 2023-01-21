// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Voting{
    mapping(bytes32=>uint8) public votesReiceived;
    bytes32[] public candidateList;

    constructor(bytes32[] memory candidateNames)  {
        candidateList = candidateNames;
    }

    function validCandidate(bytes32 _candidate) public view returns(bool){
        for(uint i=0;i<candidateList.length;i++){
            if(candidateList[i]== _candidate){
                return true;
            }
        }
        return false;
    }

    function totalVotesFor(bytes32 _candidate) public view returns(uint8){
        require(validCandidate(_candidate));
        return votesReiceived[_candidate];
    }

    function voteForCandidate(bytes32 _candidate) public{
        require(validCandidate(_candidate));
        votesReiceived[_candidate] += 1;
    }
}