// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

address public admin;
address public valuationContract;

constructor(string memory name, string memory symbol, address _valuationContract) ERC20(name, symbol) {
    admin = msg.sender;
    valuationContract = _valuationContract;
}

// Modifier pour restreindre certaines fonctions à l'administrateur
modifier onlyAdmin() {
    require(msg.sender == admin, "Seul l'administrateur peut effectuer cette action.");
    _;
}

// Fonction pour émettre des jetons représentant les actifs de l'entreprise
function issueTokens(address to, uint256 amount) public onlyAdmin {
    _mint(to, amount);
}

// Fonction pour brûler des jetons en cas de besoin
function burnTokens(uint256 amount) public {
    _burn(msg.sender, amount);
}