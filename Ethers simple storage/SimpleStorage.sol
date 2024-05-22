// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
    uint favoriteNumber;

    //mapping is key value pare to store data in map
    mapping(string => uint) public nameToFuensction;

    struct People {
        uint favoriteNumber;
        string name;
    }

    People[] public people;

    function store(uint _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint) {
        return favoriteNumber;
    }

    function addPeople(string memory _name, uint _favoriteNumber) public {
        People memory newPeople = People(_favoriteNumber, _name);
        people.push(newPeople);
        nameToFuensction[_name] = _favoriteNumber; //this will create a new entry in the nameToFuensction mapping
    }
}
