// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StructProfileContract.sol";  
import "./";
library SafeMath {
    event UserRegistered(address indexed user, ProfileType profileType);
    event DocumentHashStored(address indexed user, ProfileType profileType, string documentType, bytes32 documentHash);
    event UserProfileUpdated(address indexed user);
    event UserValidated(address indexed user);
    event AccountTypeChanged(address indexed user, ProfileType newType);

    // Fonction pour stocker les hashes des documents après leur vérification hors chaîne
    // Ajout de l'argument 'profileType' pour spécifier le type de profil
    function storeDocumentHashes(
        ProfileType profileType,
        string[] memory documentTypes,
        bytes32[] memory documentHashes
    ) public {
        require(documentTypes.length == documentHashes.length, "Document types and hashes length mismatch");

        for (uint i = 0; i < documentTypes.length; i++) {
            // Stockage du hash de chaque document en fonction du type de profil et du type de document fourni
            userDocumentHashes[msg.sender][profileType][documentTypes[i]] = documentHashes[i];
            emit DocumentHashStored(msg.sender, profileType, documentTypes[i], documentHashes[i]);
        }
    }

    // Fonction pour mettre à jour les informations de profil
    function updateProfile(
        string memory fullName,
        string memory email,
        string memory additionalInfo // Utilisez additionalInfo pour des informations supplémentaires spécifiques au type de profil
    ) public {
        require(users[msg.sender].isVerified, "User must be verified to update profile");
        require(bytes(fullName).length > 0, "Full name is required");
        require(bytes(email).length > 0, "Email is required");
        require(!emailExists[email] || users[msg.sender].personalInfo.email == email, "Email is already used");

        User storage user = users[msg.sender];

        if (user.profileType == ProfileType.Personal) {
            user.personalInfo.fullName = fullName;
            user.personalInfo.email = email;
            // Mettez à jour additionalInfo comme nécessaire, par exemple, physicalAddress ou phoneNumber
        } else {
            user.businessInfo.companyName = fullName;
            // Mettez à jour additionalInfo comme nécessaire, par exemple, companyAddress ou companyID
        }

        emit UserProfileUpdated(msg.sender);
    }

    // Fonction pour changer le type de compte d'un utilisateur
    function setAccountType(ProfileType newType) public {
        require(users[msg.sender].isVerified, "User must be verified to change account type");
        users[msg.sender].profileType = newType;
        emit AccountTypeChanged(msg.sender, newType);
    }

    function isValidDocumentFormat(string memory documentHash) internal pure returns (bool) {
        return bytes(documentHash).length > 10;
    }

    function registerProfile(
        ProfileType profileType,
        string memory fullName,
        string memory physicalAddress,
        string memory email,
        string memory phoneNumber,
        string memory idDocumentHash,
        string memory proofOfAddressHash,
        string memory professionalLicenseHash,
        string memory companyName,
        string memory companyAddress,
        string memory companyID,
        string memory vatCertificateHash,
        string memory businessDeclarationHash,
        string memory incorporationDeclarationHash,
        string memory liabilityInsuranceCertificateHash,
        string memory governmentAuthorizationsHash,
        string memory propertyContractsHash,
        string memory employeeDeclarationsHash,
        string memory commerceRegistryCertificateHash,
        string memory bankDetails,
        string memory financialStatementsHash
    ) public {
        if (profileType == ProfileType.Personal) {
            setPersonalUser(
                fullName,
                physicalAddress,
                email,
                phoneNumber,
                idDocumentHash,
                proofOfAddressHash,
                professionalLicenseHash,
                bankDetails,
                financialStatementsHash
            );
        } else if (profileType == ProfileType.Business) {
            setBusinessOwner(
                companyName,
                companyAddress,
                companyID,
                vatCertificateHash,
                businessDeclarationHash,
                incorporationDeclarationHash,
                liabilityInsuranceCertificateHash,
                governmentAuthorizationsHash,
                propertyContractsHash,
                employeeDeclarationsHash,
                commerceRegistryCertificateHash,
                bankDetails,
                financialStatementsHash
            );
        }

        emit UserRegistered(msg.sender, profileType);
    }

    function setPersonalUser(
        string memory fullName,
        string memory physicalAddress,
        string memory email,
        string memory phoneNumber,
        string memory idDocumentHash,
        string memory proofOfAddressHash,
        string memory professionalLicenseHash,
        string memory bankDetails,
        string memory financialStatementsHash
    ) internal {
        require(bytes(fullName).length > 0, "Full name is required");
        require(bytes(physicalAddress).length > 0, "Physical address is required");
        require(bytes(email).length > 0, "Email is required");
        require(bytes(phoneNumber).length > 0, "Phone number is required");
        require(!emailExists[email], "Email is already used");
        require(!phoneExists[phoneNumber], "Phone number is already used");
        require(isValidDocumentFormat(idDocumentHash), "Invalid ID document format");
        require(isValidDocumentFormat(proofOfAddressHash), "Invalid proof of address format");
        require(isValidDocumentFormat(professionalLicenseHash), "Invalid professional license format");
        require(bytes(bankDetails).length > 0, "Bank details are required");
        require(isValidDocumentFormat(financialStatementsHash), "Invalid financial statements format");
        require(bytes(bankDetails).length <= 100, "Bank details are too large");

        users[msg.sender].isVerified = true;
        emailExists[email] = true;
        phoneExists[phoneNumber] = true;

        users[msg.sender].personalInfo = PersonalInfo(
            fullName,
            physicalAddress,
            email,
            phoneNumber,
            "",
            PersonalVerificationDocuments(idDocumentHash, proofOfAddressHash, professionalLicenseHash)
        );
        users[msg.sender].financialInfo = FinancialInfo(bankDetails, financialStatementsHash);
    }

    function setBusinessOwner(
        string memory companyName,
        string memory companyAddress,
        string memory companyID,
        string memory vatCertificateHash,
        string memory businessDeclarationHash,
        string memory incorporationDeclarationHash,
        string memory liabilityInsuranceCertificateHash,
        string memory governmentAuthorizationsHash,
        string memory propertyContractsHash,
        string memory employeeDeclarationsHash,
        string memory commerceRegistryCertificateHash,
        string memory bankDetails,
        string memory financialStatementsHash
    ) internal {
        require(bytes(companyName).length > 0, "Company name is required");
        require(bytes(companyAddress).length > 0, "Company address is required");
        require(bytes(companyID).length > 0, "Company ID is required");
        require(!companyNames[companyName], "Company name already registered");
        require(isValidDocumentFormat(vatCertificateHash), "Invalid VAT certificate format");
        require(isValidDocumentFormat(businessDeclarationHash), "Invalid business declaration format");
        require(isValidDocumentFormat(incorporationDeclarationHash), "Invalid incorporation declaration format");
        require(isValidDocumentFormat(liabilityInsuranceCertificateHash), "Invalid liability insurance certificate format");
        require(isValidDocumentFormat(governmentAuthorizationsHash), "Invalid government authorizations format");
        require(isValidDocumentFormat(propertyContractsHash), "Invalid property contracts format");
        require(isValidDocumentFormat(employeeDeclarationsHash), "Invalid employee declarations format");
        require(isValidDocumentFormat(commerceRegistryCertificateHash), "Invalid commerce registry certificate format");
        require(isValidDocumentFormat(bankDetails), "Invalid bank details format");
        require(isValidDocumentFormat(financialStatementsHash), "Invalid financial statements format");

        users[msg.sender].isVerified = true;
        companyNames[companyName] = true;

        users[msg.sender].businessInfo = BusinessInfo(
            companyName,
            companyAddress,
            companyID,
            ""
        );
        users[msg.sender].companyDocs = CompanyVerificationDocuments(
            vatCertificateHash,
            businessDeclarationHash,
            incorporationDeclarationHash,
            liabilityInsuranceCertificateHash,
            governmentAuthorizationsHash,
            propertyContractsHash,
            employeeDeclarationsHash,
            commerceRegistryCertificateHash
        );
        users[msg.sender].financialInfo = FinancialInfo(bankDetails, financialStatementsHash);
    }

    function validateUser(address userAddress) public onlyAdmin {
        require(!users[userAddress].isVerified, "User is already verified");
        users[userAddress].isVerified = true;
        emit UserValidated(userAddress);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }
}
