document.addEventListener('DOMContentLoaded', function() {
    // Modal handling code (same as before)
    const followBtn = document.querySelector('.follow-btn');
    const profileEditBtn = document.querySelector('.scndry-btns .edit-btn');
    const interestsModal = document.getElementById('interestsModal');
    const editModal = document.getElementById('editModal');
    const closeBtns = document.querySelectorAll('.close-btn');
    const modalCancelBtns = document.querySelectorAll('.cancel-btn');
    const prefCancelBtn = document.querySelector('.pref-cancel');

    interestsModal.style.display = "none";
    editModal.style.display = "none";

    followBtn.addEventListener('click', (e) => {
      e.preventDefault();
      interestsModal.style.display = "flex";
    });

    profileEditBtn.addEventListener('click', (e) => {
      e.preventDefault();
      editModal.style.display = "flex";
    });

    closeBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        interestsModal.style.display = "none";
        editModal.style.display = "none";
      });
    });

    modalCancelBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        if (btn.closest('.modal-content') === interestsModal.querySelector('.modal-content')) {
          // This is the cancel button in interestsModal
          revertToOriginalValues();
        }
        interestsModal.style.display = "none";
        editModal.style.display = "none";
      });
    });

    window.addEventListener('click', (event) => {
      if (event.target === interestsModal || event.target === editModal) {
        interestsModal.style.display = "none";
        editModal.style.display = "none";
      }
    });

    // Table editing functionality
    const prefEditBtn = document.getElementById('pref-edit');
    const prefSaveBtn = document.getElementById('pref-save');

    let originalValues = [];

    prefEditBtn.addEventListener('click', function() {
      prefEditBtn.style.display = 'none';
      document.querySelector('.action').style.display = 'flex';

      originalValues = [];
      const tables = document.querySelectorAll('.table-cont table');

      tables.forEach(table => {
        const tableData = [];
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
          const cell = row.querySelector('td:nth-child(2)');
          tableData.push({
            value: cell.textContent,
            options: cell.getAttribute('data-options')
          });
        });

        originalValues.push(tableData);
      });

      convertCellsToDropdowns();
    });

    prefSaveBtn.addEventListener('click', function() {
      prefEditBtn.style.display = 'flex';
      document.querySelector('.action').style.display = 'none';
      convertDropdownsToCells();
      console.log("Data saved:", getCurrentValues());
    });

    // Add event listener for pref-cancel button
    prefCancelBtn.addEventListener('click', function() {
      prefEditBtn.style.display = 'flex';
      document.querySelector('.action').style.display = 'none';
      revertToOriginalValues();
      convertDropdownsToCells(); // Ensure dropdowns are converted back to cells
    });

    function convertCellsToDropdowns() {
      const tables = document.querySelectorAll('.table-cont table');

      tables.forEach(table => {
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
          const cell = row.querySelector('td:nth-child(2)');
          const currentValue = cell.textContent.trim();
          const options = cell.getAttribute('data-options').split(',');

          let selectHtml = '<select>';
          options.forEach(option => {
            const selected = option.trim() === currentValue ? ' selected' : '';
            selectHtml += `<option value="${option.trim()}"${selected}>${option.trim()}</option>`;
          });
          selectHtml += '</select>';

          cell.innerHTML = selectHtml;
        });
      });
    }

    function convertDropdownsToCells() {
      const tables = document.querySelectorAll('.table-cont table');

      tables.forEach(table => {
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
          const cell = row.querySelector('td:nth-child(2)');
          const select = cell.querySelector('select');

          if (select) {
            cell.textContent = select.value;
          }
        });
      });
    }

    function revertToOriginalValues() {
      const tables = document.querySelectorAll('.table-cont table');

      tables.forEach((table, tableIndex) => {
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach((row, rowIndex) => {
          const cell = row.querySelector('td:nth-child(2)');
          if (originalValues[tableIndex] && originalValues[tableIndex][rowIndex]) {
            cell.textContent = originalValues[tableIndex][rowIndex].value;
          }
        });
      });
    }

    function getCurrentValues() {
      const values = [];
      const tables = document.querySelectorAll('.table-cont table');

      tables.forEach(table => {
        const tableData = [];
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
          const cell = row.querySelector('td:nth-child(2)');
          tableData.push(cell.textContent);
        });

        values.push(tableData);
      });

      return values;
    }

    // Location dropdown functionality
    const citiesByProvince = {
      western: ["Colombo", "Negombo", "Moratuwa", "Panadura", "Kalutara", "Gampaha", "Horana"],
      central: ["Kandy", "Matale", "Nuwara Eliya", "Gampola", "Dambulla", "Hatton"],
      southern: ["Galle", "Matara", "Hambantota", "Weligama", "Tangalle", "Ambalangoda"],
      northern: ["Jaffna", "Vavuniya", "Kilinochchi", "Mullaitivu", "Mannar"],
      eastern: ["Batticaloa", "Trincomalee", "Kalmunai", "Ampara", "Akkaraipattu"],
      "north-western": ["Kurunegala", "Puttalam", "Chilaw", "Narammala", "Wariyapola"],
      "north-central": ["Anuradhapura", "Polonnaruwa", "Medawachchiya", "Habarana", "Kekirawa"],
      uva: ["Badulla", "Monaragala", "Bandarawela", "Haputale", "Welimada"],
      sabaragamuwa: ["Ratnapura", "Kegalle", "Balangoda", "Embilipitiya", "Kuruwita"],
    };

    function updateCities() {
      const provinceSelect = document.getElementById("province-drop");
      const citySelect = document.getElementById("city");
      const selectedProvince = provinceSelect.value;

      citySelect.innerHTML = "";

      if (selectedProvince) {
        citySelect.disabled = false;
        citySelect.add(new Option("-- Select City --", ""));

        citiesByProvince[selectedProvince].forEach((city) => {
          citySelect.add(
            new Option(city, city.toLowerCase().replace(" ", "-"))
          );
        });
      } else {
        citySelect.disabled = true;
        citySelect.add(new Option("-- First select a province --", ""));
      }
    }

    document.getElementById("province-drop").addEventListener("change", updateCities);
  });
