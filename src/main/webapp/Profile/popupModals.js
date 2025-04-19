document.addEventListener('DOMContentLoaded', function() {
    // Clean up data-options by removing trailing commas
    const cleanDataOptions = () => {
        const optionCells = document.querySelectorAll('td[data-options]');

        optionCells.forEach(cell => {
            let options = cell.getAttribute('data-options');
            // Remove trailing comma if it exists
            if (options.endsWith(',')) {
                options = options.slice(0, -1);
                cell.setAttribute('data-options', options);
            }
        });
    };

    cleanDataOptions();
});



const userEditBtn = document.querySelector(".user-edit-btn");
const modal = document.getElementById("editModal");
const closeBtns = document.querySelectorAll('.close-btn');
const modalCancelBtns = document.querySelectorAll('.cancel-btn');
const interestsModal = document.getElementById('interestsModal');
const intrstBtn = document.querySelector('.intrst-btn');
const prefCancelBtn = document.querySelector('.pref-cancel');


interestsModal.style.display = "none";

intrstBtn.addEventListener('click', (e) => {
    e.preventDefault();
    interestsModal.style.display = "flex";
    document.querySelector(".pref-action").style.display= "none";
});


// Initially hide the modal
modal.style.display = "none";

// Open modal on button click
// Update the modal opening event
userEditBtn.addEventListener("click", () => {
    modal.style.display = "flex";

    // Reinitialize cities when modal opens
    const provinceSelect = document.getElementById("province-drop");
    if (provinceSelect.value) {
        updateCities();
    }
});

// Close modal on close button click
closeBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        interestsModal.style.display = "none";
        modal.style.display = "none";
    });
});


modalCancelBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        if (btn.closest('.modal-content') === interestsModal.querySelector('.modal-content')) {
            // This is the cancel button in interestsModal
            revertToOriginalValues();
        }
        interestsModal.style.display = "none";
        modal.style.display = "none";
    });
});

// Close modal when clicking outside the modal content
window.addEventListener('click', (event) => {
    if (event.target === interestsModal || event.target === editModal) {
        interestsModal.style.display = "none";
        modal.style.display = "none";
    }
});

// user interests functions
// Table editing functionality
const prefEditBtn = document.getElementById('pref-edit');
const prefSaveBtn = document.getElementById('pref-save');

let originalPreferences = {};

prefEditBtn.addEventListener('click', function() {
    // Hide edit button and show save/cancel buttons
    prefEditBtn.style.display = 'none';
    document.querySelector('.pref-action').style.display = 'flex';

    // Store original values
    originalPreferences = {};
    document.querySelectorAll('.politician-cell').forEach(cell => {
        const rank = cell.dataset.rank;
        const displayValue = cell.querySelector('.display-value').textContent.trim();
        const select = cell.querySelector('select');

        originalPreferences[rank] = {
            displayValue: displayValue,
            selectedValue: select.value
        };

        // Show select and hide display value
        cell.querySelector('.display-value').style.display = 'none';
        select.style.display = 'block';
    });
});

prefSaveBtn.addEventListener('click', function() {
    // Validate selections first
    let isValid = true;
    const preferences = [];

    document.querySelectorAll('.politician-select').forEach(select => {
        if (!select.value) {
            isValid = false;
            select.style.border = '1px solid red';
        } else {
            select.style.border = '';
            preferences.push({
                rank: parseInt(select.dataset.rank),
                politicianId: parseInt(select.value)
            });
        }
    });

    if (!isValid) {
        alert('Please select a politician for each rank');
        return;
    }

    // Prepare data for saving
    const userId = document.querySelector('.profile-container').dataset.userId; // Make sure to set this in your HTML

    // Send to server
    savePreferences(preferences);
});

prefCancelBtn.addEventListener('click', function() {
    // Revert to original values
    document.querySelectorAll('.politician-cell').forEach(cell => {
        const rank = cell.dataset.rank;
        const original = originalPreferences[rank];

        if (original) {
            cell.querySelector('.display-value').textContent = original.displayValue;
            cell.querySelector('select').value = original.selectedValue;

            // Show display value and hide select
            cell.querySelector('.display-value').style.display = 'inline';
            cell.querySelector('select').style.display = 'none';
        }
    });

    // Hide action buttons and show edit button
    prefEditBtn.style.display = 'flex';
    document.querySelector('.pref-action').style.display = 'none';
});

function savePreferences(preferences) {
    // Get user ID from HTML
    const userId = document.querySelector('.profile-container').dataset.userId;
    if (!userId) {
        alert('User session expired. Please log in again.');
        return;
    }

    // Prepare data
    const preferenceData = {
        userId: userId,
        rank1PoliticianId: 0,
        rank2PoliticianId: 0,
        rank3PoliticianId: 0
    };

    preferences.forEach(pref => {
        switch(pref.rank) {
            case 1: preferenceData.rank1PoliticianId = pref.politicianId; break;
            case 2: preferenceData.rank2PoliticianId = pref.politicianId; break;
            case 3: preferenceData.rank3PoliticianId = pref.politicianId; break;
        }
    });

    // Get context path (for proper URL)
    const contextPath = window.location.pathname.split('/')[1];
    const url = contextPath ? `/${contextPath}/SetPoliticsPreference` : '/SetPoliticsPreference';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(preferenceData)
    })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(`Server error: ${response.status} ${text}`);
                });
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                // Update UI on success
                document.querySelectorAll('.politician-cell').forEach(cell => {
                    const rank = cell.dataset.rank;
                    const select = cell.querySelector('select');
                    const selectedOption = select.options[select.selectedIndex];

                    cell.querySelector('.display-value').textContent = selectedOption.text;
                    select.style.display = 'none';
                    cell.querySelector('.display-value').style.display = 'inline';
                });

                prefEditBtn.style.display = 'flex';
                document.querySelector('.pref-action').style.display = 'none';
                alert('Preferences saved successfully!');
            } else {
                throw new Error(data.message || 'Failed to save preferences');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error saving preferences: ' + error.message);
            prefCancelBtn.click();
        });
}

function convertCellsToDropdowns() {
    const tables = document.querySelectorAll('.table-cont table');

    tables.forEach(table => {
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
            const cell = row.querySelector("td:nth-child(2)");
            const currentValue = cell.textContent.trim();
            const options = cell.getAttribute('data-options').split(',');

            let selectHtml = '<select>';
            options.forEach(option => {
                const selected = option.trim() === currentValue ? ' selected' : '';
                selectHtml += `<option value='${option.trim()}'${selected}>${option.trim()}</option>`;
            });
            selectHtml += '</select>';
            console.log(selectHtml);
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

const citiesByProvince = {
    western: [
        "Colombo",
        "Negombo",
        "Moratuwa",
        "Panadura",
        "Kalutara",
        "Gampaha",
        "Horana",
    ],
    central: [
        "Kandy",
        "Matale",
        "Nuwara Eliya",
        "Gampola",
        "Dambulla",
        "Hatton",
    ],
    southern: [
        "Galle",
        "Matara",
        "Hambantota",
        "Weligama",
        "Tangalle",
        "Ambalangoda",
    ],
    northern: [
        "Jaffna",
        "Vavuniya",
        "Kilinochchi",
        "Mullaitivu",
        "Mannar",
    ],
    eastern: [
        "Batticaloa",
        "Trincomalee",
        "Kalmunai",
        "Ampara",
        "Akkaraipattu",
    ],
    "north-western": [
        "Kurunegala",
        "Puttalam",
        "Chilaw",
        "Narammala",
        "Wariyapola",
    ],
    "north-central": [
        "Anuradhapura",
        "Polonnaruwa",
        "Medawachchiya",
        "Habarana",
        "Kekirawa",
    ],
    uva: [
        "Badulla",
        "Monaragala",
        "Bandarawela",
        "Haputale",
        "Welimada",
    ],
    sabaragamuwa: [
        "Ratnapura",
        "Kegalle",
        "Balangoda",
        "Embilipitiya",
        "Kuruwita",
    ],
};

