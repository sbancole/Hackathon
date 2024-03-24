// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
  struct ValuationData {
        uint256 valuation; // Valorisation de l'entreprise
        string dataHash; // Hash des données de valorisation pour vérification
        address assetToken; // Adresse du token représentant l'actif numérique de l'entreprise
    }
