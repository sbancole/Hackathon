// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FunctionContract.sol";
import "./StructProfileContract.sol";

contract UserProfileContract  {
    address public admin;

    // Déclaration des mappings pour vérifier l'unicité des informations
    mapping(string => bool) emailExists;
    mapping(string => bool) phoneExists;
    mapping(string => bool) companyNames;
    mapping(address => User) users;
    mapping(address => mapping(ProfileType => mapping(string => bytes32))) internal  userDocumentHashes;


    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }


   
}
