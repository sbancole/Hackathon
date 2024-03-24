// Fonction pour afficher la page de chargement
function showLoadingPage() {
    document.getElementById("loadingPage").style.display = "flex";
    setTimeout(() => {
        document.getElementById("loadingPage").style.display = "none";
        openConfirmationPopup();
    }, 5000); // Changez la durée selon le temps nécessaire pour la création du compte
}

// Fonction pour ouvrir le popup de confirmation
function openConfirmationPopup() {
    document.getElementById("confirmationPopup").style.display = "block";
}

// Fonction pour fermer le popup de confirmation
function closePopup() {
    document.getElementById("confirmationPopup").style.display = "none";
}

// Ajoutez cette fonction à l'événement 'onclick' du bouton 'S'inscrire' dans votre formulaire
function onRegisterClicked() {
    // Ici, vous pouvez ajouter votre logique de validation de formulaire
    showLoadingPage();
}
