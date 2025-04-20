<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./editPoliticianPublicDetails.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"/>

</head>
<body>
<div class="modal">
    <div class="details-modal">
        <div class="top f-row">
            <div class="title caps">personal details</div>
            <button id="close-modal">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <div class="center f-col">
            <div class="detail-group f-col">
                <div class="details f-col">
                    <table class="detail" id="political-detail-table">
                        <tr class="title caps">
                            <td colspan="2">political</td>
                        </tr>
                        <tr>
                            <td class="label">party</td>
                            <td class="value">progressive party</td>
                        </tr>
                        <tr>
                            <td class="label">electorial level</td>
                            <td class="value">1</td>
                        </tr>
                        <tr>
                            <td class="label">electorial province</td>
                            <td class="value">western province</td>
                        </tr>
                        <tr>
                            <td class="label">current position</td>
                            <td class="value">parliment minister</td>
                        </tr>
                    </table>
                    <table class="detail" id="latest-elec-table">
                        <tr class="title caps">
                            <td colspan="2">latest election</td>
                        </tr>
                        <tr>
                            <td class="label">party</td>
                            <td class="value">progressive party</td>
                        </tr>
                        <tr>
                            <td class="label">electorial level</td>
                            <td class="value">1</td>
                        </tr>
                        <tr>
                            <td class="label">electorial province</td>
                            <td class="value">western province</td>
                        </tr>
                        <tr>
                            <td class="label">current position</td>
                            <td class="value">parliment minister</td>
                        </tr>
                    </table>
                    <table class="detail" id="policy-table">
                        <tr class="title caps">
                            <td colspan="2">policies</td>
                        </tr>
                        <tr>
                            <td class="label">party</td>
                            <td class="value">progressive party</td>
                        </tr>
                        <tr>
                            <td class="label">electorial level</td>
                            <td class="value">1</td>
                        </tr>
                        <tr>
                            <td class="label">electorial province</td>
                            <td class="value">western province</td>
                        </tr>
                        <tr>
                            <td class="label">current position</td>
                            <td class="value">parliment minister</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="footer f-row">
            <div class="edit caps">
                <button id="edit-btn">edit</button>
            </div>
            <div class="action f-row">
                <button id="cancel-btn">cancel</button>
                <button id="save-btn">save</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <button id="open-details-popup">edit details</button>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        // Get DOM elements
        const modal = document.querySelector('.modal');
        const openPopupBtn = document.getElementById('open-details-popup');
        const closeModalBtn = document.getElementById('close-modal');
        const editBtn = document.getElementById('edit-btn');
        const cancelBtn = document.getElementById('cancel-btn');
        const saveBtn = document.getElementById('save-btn');
        const actionDiv = document.querySelector('.action');

        // Political data options
        const politicalData = {
            parties: ['Progressive Party', 'Conservative Alliance', 'Liberal Democrats', 'Green Movement', 'Socialist Front'],
            electoralLevels: ['1 - National', '2 - Regional', '3 - District', '4 - Local'],
            electoralProvinces: ['Western Province', 'Eastern Province', 'Northern Territory', 'Southern Region', 'Central District'],
            positions: ['Parliament Minister', 'Party Leader', 'Opposition Member', 'Committee Chair', 'Backbencher']
        };

        // Store original values
        let originalValues = {};

        // Open modal when edit details button is clicked
        openPopupBtn.addEventListener('click', function() {
            modal.style.display = 'flex';
            resetToViewMode();
        });

        // Close modal when X is clicked
        closeModalBtn.addEventListener('click', function() {
            modal.style.display = 'none';
            // Reset to non-edit mode when closing
            resetToViewMode();
        });

        // Edit button functionality
        editBtn.addEventListener('click', function() {
            enterEditMode();
        });

        // Cancel button functionality
        cancelBtn.addEventListener('click', function() {
            resetToViewMode();
        });

        // Save button functionality
        saveBtn.addEventListener('click', function() {
            saveChanges();
        });

        // Close modal when clicking outside the modal content
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                modal.style.display = 'none';
                resetToViewMode();
            }
        });

        function enterEditMode() {
            // Hide edit button and show action buttons
            editBtn.style.display = 'none';
            actionDiv.style.display = 'flex';

            // Convert all value cells to dropdowns and store original values
            const valueCells = document.querySelectorAll('td.value');
            valueCells.forEach((cell, index) => {
                // Store original value
                originalValues[`cell${index}`] = cell.textContent.trim();

                // Get the label from previous cell to determine what dropdown to show
                const label = cell.previousElementSibling.textContent.trim().toLowerCase();

                // Create select element
                const select = document.createElement('select');

                // Populate options based on label
                if (label.includes('party')) {
                    politicalData.parties.forEach(party => {
                        const option = document.createElement('option');
                        option.value = party;
                        option.textContent = party;
                        option.selected = (party.toLowerCase() === cell.textContent.trim().toLowerCase());
                        select.appendChild(option);
                    });
                }
                else if (label.includes('level')) {
                    politicalData.electoralLevels.forEach(level => {
                        const option = document.createElement('option');
                        option.value = level;
                        option.textContent = level;
                        option.selected = (level.includes(cell.textContent.trim()));
                        select.appendChild(option);
                    });
                }
                else if (label.includes('province')) {
                    politicalData.electoralProvinces.forEach(province => {
                        const option = document.createElement('option');
                        option.value = province;
                        option.textContent = province;
                        option.selected = (province.toLowerCase() === cell.textContent.trim().toLowerCase());
                        select.appendChild(option);
                    });
                }
                else if (label.includes('position')) {
                    politicalData.positions.forEach(position => {
                        const option = document.createElement('option');
                        option.value = position;
                        option.textContent = position;
                        option.selected = (position.toLowerCase() === cell.textContent.trim().toLowerCase());
                        select.appendChild(option);
                    });
                }

                // Replace cell content with select
                cell.textContent = '';
                cell.appendChild(select);
            });
        }

        function resetToViewMode() {
            // Show edit button and hide action buttons
            editBtn.style.display = 'block';
            actionDiv.style.display = 'none';

            // Revert all changes back to original values
            const valueCells = document.querySelectorAll('td.value');
            valueCells.forEach((cell, index) => {
                // Remove any select elements
                if (cell.querySelector('select')) {
                    cell.removeChild(cell.querySelector('select'));
                }
                // Restore original value
                cell.textContent = originalValues[`cell${index}`] || cell.textContent;
            });
        }

        function saveChanges() {
            // Update all values from dropdowns
            const valueCells = document.querySelectorAll('td.value');
            valueCells.forEach((cell, index) => {
                if (cell.querySelector('select')) {
                    const select = cell.querySelector('select');
                    // Update the originalValues with the new selected value
                    originalValues[`cell${index}`] = select.value;
                    // Update the cell content
                    cell.textContent = select.value;
                }
            });

            // Now reset to view mode
            resetToViewMode();

            // Here you would typically send the updated data to your server
            console.log("Saved changes:", originalValues);
        }
    });
</script>
</body>
</html>