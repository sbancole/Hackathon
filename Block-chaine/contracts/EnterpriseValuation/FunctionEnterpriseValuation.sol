// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library  SafeMath{
// Administrateur du contrat
    address public admin;

    // Mapping d'une entreprise à ses données de valorisation
    mapping(address => ValuationData) public valuations;

    // Événement émis lorsqu'une valorisation est mise à jour
    event ValuationUpdated(address indexed enterprise, uint256 valuation, string dataHash, address assetToken);

    constructor() {
        admin = msg.sender;
    }

    // Modifier pour restreindre certaines fonctions à l'administrateur
    modifier onlyAdmin() {
        require(msg.sender == admin, "Seul l'administrateur peut effectuer cette action.");
        _;
    }

    // Fonction pour mettre à jour la valorisation d'une entreprise
    function updateValuation(address enterprise, uint256 valuation, string memory dataHash, address assetToken) public onlyAdmin {
        valuations[enterprise] = ValuationData(valuation, dataHash, assetToken);
        emit ValuationUpdated(enterprise, valuation, dataHash, assetToken);
    }
}
