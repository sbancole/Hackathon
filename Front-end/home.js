$(document).ready(function () {
  var serviceGroups = $('.service-group');
  var currentIndex = 0;

  function updateButtons() {
      $('.prev-btn').toggle(currentIndex > 0);
      $('.next-btn').toggle(currentIndex < serviceGroups.length - 1);
  }

  $('.next-btn').click(function () {
      if (currentIndex < serviceGroups.length - 1) {
          $(serviceGroups[currentIndex]).hide();
          currentIndex++;
          $(serviceGroups[currentIndex]).show();
          updateButtons();
      }
  });

  $('.prev-btn').click(function () {
      if (currentIndex > 0) {
          $(serviceGroups[currentIndex]).hide();
          currentIndex--;
          $(serviceGroups[currentIndex]).show();
          updateButtons();
      }
  });

  updateButtons(); // Mise à jour initiale des boutons
});

window.addEventListener('DOMContentLoaded', function () {
  // Sélectionnez la div avec la classe .content-container dans la partie gauche
  const contentContainer = document.querySelector('.about-section .col-md-6 .content-container');

  // Sélectionnez la div avec la classe .col-md-6 dans la partie droite
  const rightColumn = document.querySelector('.about-section .col-md-6');

  // Fonction pour ajuster la hauteur de la partie gauche en fonction de la partie droite
  function adjustHeight() {
      const rightColumnHeight = rightColumn.offsetHeight; // Hauteur de la partie droite
      contentContainer.style.height = rightColumnHeight + 'px'; // Ajuster la hauteur de la partie gauche
  }

  // Appelez la fonction d'ajustement de la hauteur lors du chargement de la page et du redimensionnement de la fenêtre
  adjustHeight();
  window.addEventListener('resize', adjustHeight);
});

function toggleTheme() {
  const body = document.body;
  body.classList.toggle("light-theme");
  body.classList.toggle("dark-theme");
}

// Données simulées pour les stocks
var stocksData = [
  { name: 'Entreprise A', price: '120€', variation: '+1.50%', volume: '2M', cap: '50B€' },
  { name: 'Entreprise B', price: '98€', variation: '-0.85%', volume: '1.5M', cap: '75B€' },
  // Ajoutez autant d'objets que nécessaire ici
];

// Cette fonction sera appelée lorsque le DOM sera complètement chargé
document.addEventListener('DOMContentLoaded', function () {
  var tbody = document.getElementById('stock-table-body');

  stocksData.forEach(function(stock) {
      var tr = document.createElement('tr');
      tr.innerHTML = '<td>' + stock.name + '</td>' +
          '<td>' + stock.price + '</td>' +
          '<td>' + stock.variation + '</td>' +
          '<td>' + stock.volume + '</td>' +
          '<td>' + stock.cap + '</td>';
      tbody.appendChild(tr);
  });
});

// Simuler un appel API ou une récupération de données
const additionalStocksData = [
 // { name: 'Entreprise A', price: '120,00€', variation: '+1.50%', volume: '2M', cap: '50B€' },
  //{ name: 'Entreprise B', price: '98,75€', variation: '-0.85%', volume: '1.5M', cap: '75B€' },
  // Ajoutez d'autres données ici
];

// Fonction pour peupler la table avec des données supplémentaires
function populateTable(data) {
  const stocksBody = document.getElementById('stocks-body');
  data.forEach(stock => {
      const row = document.createElement('tr');
      row.innerHTML = `
          <td>${stock.name}</td>
          <td>${stock.price}</td>
          <td class="${stock.variation.startsWith('+') ? 'positive' : 'negative'}">${stock.variation}</td>
          <td>${stock.volume}</td>
          <td>${stock.cap}</td>
      `;
      stocksBody.appendChild(row);
  });
}

// Appeler la fonction au chargement de la page
document.addEventListener('DOMContentLoaded', () => populateTable(additionalStocksData));
