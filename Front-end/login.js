function displayFields() {
    var userType = document.getElementById("userType").value;

    document.getElementById("basicFields").style.display = "none";
    document.getElementById("investorFields").style.display = "none";
    document.getElementById("enterpriseFields").style.display = "none";

    if (userType === "basic") {
        document.getElementById("basicFields").style.display = "block";
    } else if (userType === "investor") {
        document.getElementById("investorFields").style.display = "block";
    } else if (userType === "enterprise") {
        document.getElementById("enterpriseFields").style.display = "block";
    }
}

// Fonction pour ouvrir le popup
function openPopup() {
    document.getElementById("confirmationPopup").style.display = "block";
}

// Fonction pour fermer le popup
function closePopup() {
    document.getElementById("confirmationPopup").style.display = "none";
}

// Supposons que c'est votre fonction de validation de formulaire
function validateAccount() {
    // Votre logique de validation ici
    // Si le compte est validé avec succès :
    openPopup();
}
