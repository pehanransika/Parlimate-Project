document.addEventListener('DOMContentLoaded', function() {
    // Initialize all functionality
    setupModals();
    setupCombinedPreferences();
    initializeCityDropdown();
});

// Modal handling functions
function setupModals() {
    const userEditBtn = document.querySelector(".user-edit-btn");
    const modal = document.getElementById("editModal");
    const closeBtns = document.querySelectorAll('.close-btn');
    const modalCancelBtns = document.querySelectorAll('.cancel-btn');
    const interestsModal = document.getElementById('interestsModal');
    const intrstBtn = document.querySelector('.intrst-btn');

    // Initialize modals as hidden
    modal.style.display = "none";
    interestsModal.style.display = "none";

    // Modal event listeners
    intrstBtn.addEventListener('click', (e) => {
        e.preventDefault();
        interestsModal.style.display = "flex";
        document.querySelector(".pref-action").style.display = "none";
    });

    userEditBtn.addEventListener("click", () => {
        modal.style.display = "flex";
        const provinceSelect = document.getElementById("province-drop");
        if (provinceSelect?.value) updateCities();
    });

    closeBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            interestsModal.style.display = "none";
            modal.style.display = "none";
        });
    });

    modalCancelBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            if (btn.closest('.modal-content') === interestsModal.querySelector('.modal-content')) {
                revertToOriginalValues();
            }
            interestsModal.style.display = "none";
            modal.style.display = "none";
        });
    });

    window.addEventListener('click', (event) => {
        if (event.target === interestsModal || event.target === editModal) {
            revertToOriginalValues();
            interestsModal.style.display = "none";
            modal.style.display = "none";
        }
    });
}

// Combined Preferences
function setupCombinedPreferences() {
    const prefEditBtn = document.getElementById('pref-edit');
    const prefSaveBtn = document.getElementById('pref-save');
    const prefCancelBtn = document.querySelector('.pref-cancel');

    if (!prefEditBtn || !prefSaveBtn || !prefCancelBtn) return;

    let originalValues = {
        politicians: {},
        parties: {}
    };

    prefEditBtn.addEventListener('click', function() {
        prefEditBtn.style.display = 'none';
        document.querySelector('.pref-action').style.display = 'flex';

        // Politicians
        document.querySelectorAll('.politician-cell').forEach(cell => {
            const rank = cell.dataset.rank;
            const displayValue = cell.querySelector('.display-value');
            const select = cell.querySelector('select');

            originalValues.politicians[rank] = {
                displayValue: displayValue.textContent,
                selectedValue: select.value
            };

            displayValue.style.display = 'none';
            select.style.display = 'block';
        });

        // Parties
        document.querySelectorAll('.party-cell').forEach(cell => {
            const rank = cell.dataset.rank;
            const displayValue = cell.querySelector('.display-value');
            const select = cell.querySelector('select');

            originalValues.parties[rank] = {
                displayValue: displayValue.textContent,
                selectedValue: select.value
            };

            displayValue.style.display = 'none';
            select.style.display = 'block';
        });
    });

    prefSaveBtn.addEventListener('click', function() {
        const preferenceData = {
            userId: document.querySelector('.profile-container').dataset.userId
        };

        let isValid = true;

        // Collect politician preferences
        document.querySelectorAll('.politician-select').forEach(select => {
            const rank = select.dataset.rank;
            if (!select.value) {
                isValid = false;
                select.style.border = '1px solid red';
            } else {
                select.style.border = '';
                preferenceData[`rank${rank}PoliticianId`] = parseInt(select.value);
            }
        });

        // Collect party preferences
        document.querySelectorAll('.party-select').forEach(select => {
            const rank = select.dataset.rank;
            if (!select.value) {
                isValid = false;
                select.style.border = '1px solid red';
            } else {
                select.style.border = '';
                preferenceData[`rank${rank}PartyId`] = parseInt(select.value);
            }
        });

        if (!isValid) {
            alert('Please make a selection for all ranks in both politicians and parties');
            return;
        }

        fetch('/Parlimate/SetPoliticsPreference', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
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
                    // Update UI for politicians
                    document.querySelectorAll('.politician-cell').forEach(cell => {
                        const select = cell.querySelector('select');
                        const selectedOption = select.options[select.selectedIndex];

                        cell.querySelector('.display-value').textContent = selectedOption.text;
                        select.style.display = 'none';
                        cell.querySelector('.display-value').style.display = 'inline';
                    });

                    // Update UI for parties
                    document.querySelectorAll('.party-cell').forEach(cell => {
                        const select = cell.querySelector('select');
                        const selectedOption = select.options[select.selectedIndex];

                        cell.querySelector('.display-value').textContent = selectedOption.text;
                        select.style.display = 'none';
                        cell.querySelector('.display-value').style.display = 'inline';
                    });

                    prefEditBtn.style.display = 'flex';
                    document.querySelector('.pref-action').style.display = 'none';
                    alert('All preferences saved successfully!');
                } else {
                    throw new Error(data.message || 'Failed to save preferences');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error saving preferences: ' + error.message);
                prefCancelBtn.click();
            });
    });

    prefCancelBtn.addEventListener('click', function() {
        // Revert politicians
        document.querySelectorAll('.politician-cell').forEach(cell => {
            const rank = cell.dataset.rank;
            const original = originalValues.politicians[rank];

            if (original) {
                cell.querySelector('.display-value').textContent = original.displayValue;
                cell.querySelector('select').value = original.selectedValue;
                cell.querySelector('.display-value').style.display = 'inline';
                cell.querySelector('select').style.display = 'none';
            }
        });

        // Revert parties
        document.querySelectorAll('.party-cell').forEach(cell => {
            const rank = cell.dataset.rank;
            const original = originalValues.parties[rank];

            if (original) {
                cell.querySelector('.display-value').textContent = original.displayValue;
                cell.querySelector('select').value = original.selectedValue;
                cell.querySelector('.display-value').style.display = 'inline';
                cell.querySelector('select').style.display = 'none';
            }
        });

        prefEditBtn.style.display = 'flex';
        document.querySelector('.pref-action').style.display = 'none';
    });
}

// City dropdown functionality
function initializeCityDropdown() {
    const citiesByProvince = {
        western: ["Colombo", "Negombo", "Moratuwa", "Panadura", "Kalutara", "Gampaha", "Horana"],
        central: ["Kandy", "Matale", "Nuwara Eliya", "Gampola", "Dambulla", "Hatton"],
        southern: ["Galle", "Matara", "Hambantota", "Weligama", "Tangalle", "Ambalangoda"],
        northern: ["Jaffna", "Vavuniya", "Kilinochchi", "Mullaitivu", "Mannar"],
        eastern: ["Batticaloa", "Trincomalee", "Kalmunai", "Ampara", "Akkaraipattu"],
        "north-western": ["Kurunegala", "Puttalam", "Chilaw", "Narammala", "Wariyapola"],
        "north-central": ["Anuradhapura", "Polonnaruwa", "Medawachchiya", "Habarana", "Kekirawa"],
        uva: ["Badulla", "Monaragala", "Bandarawela", "Haputale", "Welimada"],
        sabaragamuwa: ["Ratnapura", "Kegalle", "Balangoda", "Embilipitiya", "Kuruwita"]
    };

    const provinceSelect = document.getElementById("province-drop");
    const citySelect = document.getElementById("city");

    if (!provinceSelect || !citySelect) return;

    provinceSelect.addEventListener("change", function() {
        const selectedProvince = this.value;
        citySelect.innerHTML = "";

        if (selectedProvince) {
            citySelect.disabled = false;
            citySelect.add(new Option("-- Select City --", ""));
            citiesByProvince[selectedProvince].forEach(city => {
                citySelect.add(new Option(city, city));
            });

            // Set saved district if available
            const savedDistrict = document.querySelector('.profile-container').dataset.district;
            if (savedDistrict) {
                citySelect.value = savedDistrict;
            }
        } else {
            citySelect.disabled = true;
            citySelect.add(new Option("-- First select a province --", ""));
        }
    });

    // Initialize on load if province is already selected
    if (provinceSelect.value) {
        provinceSelect.dispatchEvent(new Event('change'));
    }
}

// Update cities function for external use
function updateCities() {
    document.getElementById("province-drop")?.dispatchEvent(new Event('change'));
}