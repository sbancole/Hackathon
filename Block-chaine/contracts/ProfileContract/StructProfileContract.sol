// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MainProfileContract.sol";     

    enum ProfileType { Personal, Business }

    struct PersonalInfo {
        string fullName;
        string physicalAddress;
        string email;
        string phoneNumber;
        string activitySector;
        PersonalVerificationDocuments verificationDocs;
    }

    struct BusinessInfo {
        string companyName;
        string companyAddress;
        string companyID;
        string activitySector;
    }

    struct PersonalVerificationDocuments {
        string idDocument;
        string proofOfAddress;
        string professionalLicense;
    }

    struct CompanyVerificationDocuments {
        string vatCertificateHash;
        string businessDeclarationHash;
        string incorporationDeclarationHash;
        string liabilityInsuranceCertificateHash;
        string governmentAuthorizationsHash;
        string propertyContractsHash;
        string employeeDeclarationsHash;
        string commerceRegistryCertificateHash;
    }

    struct FinancialInfo {
        string bankDetails;
        string financialStatementsHash;
    }

    struct Reputation {
        uint256 rating;
        uint256 reviewCount;
        Review[] reviews;
    }

    struct Review {
        address reviewer;
        uint256 rating;
        string comment;
    }

    struct User {
        PersonalInfo personalInfo;
        PersonalVerificationDocuments personalDocs;
        CompanyVerificationDocuments companyDocs;
        FinancialInfo financialInfo;
        Reputation reputation;
        bool isVerified;
        BusinessInfo businessInfo;
    }

