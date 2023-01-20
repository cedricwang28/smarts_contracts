// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFuning{
    struct Funder{
        address funderAddress;
        uint fundAmount;
    }

    struct Raiser{
        address raiserAddress;
        uint goal;
        uint amount;
        uint funderCount;
        mapping(uint=>Funder) funderMap;
    }

    uint public raiserCount;
    mapping(uint=>Raiser) public raiserMap;

    function addRaiser(address _raiserAddress, uint _goal) public{
        
        raiserCount++;
        Raiser storage newRaiser = raiserMap[raiserCount];
        newRaiser.raiserAddress = _raiserAddress;
        newRaiser.goal = _goal;
        newRaiser.amount = 0;
        newRaiser.funderCount = 0;
    }

    function contribute(uint _raiserNum) public payable{
        raiserMap[_raiserNum].amount += msg.value;
        raiserMap[_raiserNum].funderCount++;
        raiserMap[_raiserNum].funderMap[raiserMap[_raiserNum].funderCount] = Funder(msg.sender,msg.value);
    }

    function meetAmount(uint _raiserNum) public payable{
        Raiser storage _raiser = raiserMap[_raiserNum];
        if(_raiser.amount>=_raiser.goal){
            payable(_raiser.raiserAddress).transfer(_raiser.amount);
        }
    }
}

