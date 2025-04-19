// Sample fundraiser data
const fundraiserData = [
    {
        id: "fund1",
        title: "Education for Underprivileged Children",
        description: "Help us provide school supplies and tuition for 50 children in rural areas who cannot afford education.",
        category: "Education",
        contact_no: "+94112345678",
        targetAmount: "250000.00",
        currency: "LKR",
        datetime: "2023-05-15",
        photos: "images/education-fund.jpg",
        attachmentUrl: "docs/education-proposal.pdf"
    },
    {
        id: "fund2",
        title: "Community Health Center Renovation",
        description: "Renovate our local health center to provide better facilities for over 500 families in the area.",
        category: "Health",
        contact_no: "+94119876543",
        targetAmount: "500000.00",
        currency: "LKR",
        datetime: "2023-06-20",
        photos: "images/health-center.jpg",
        attachmentUrl: ""
    },
    {
        id: "fund3",
        title: "Clean Water Initiative",
        description: "Install water purification systems in 3 villages affected by chronic water shortages.",
        category: "Environment",
        contact_no: "+94117654321",
        targetAmount: "750000.00",
        currency: "LKR",
        datetime: "2023-07-10",
        photos: "",
        attachmentUrl: "docs/water-project.pdf"
    }
];

// DOM Content Loaded Event
document.addEventListener('DOMContentLoaded', function() {
    // Load fundraiser data
    loadFundraisers();
    
    // Set up sidebar toggle
    setupSidebar();
    
    // Set up form submission
    setupForm();
});

// Load fundraisers into the page
function loadFundraisers() {
    const fundraiserList = document.getElementById('fundraiserList');
    
    fundraiserData.forEach(fundraiser => {
        const fundraiserItem = document.createElement('li');
        fundraiserItem.className = 'fundraiser-item col';
        fundraiserItem.innerHTML = `
            <div class="fundraiser-header">
                <span class="title">${fundraiser.title}</span>
                <p class="date">${fundraiser.datetime}</p>
            </div>
            <div class="fundraiser-content col">
                <p>Description: <span>${fundraiser.description}</span></p>
                <p>Category: <span>${fundraiser.category}</span></p>
                <p>Contact Number: <span>${fundraiser.contact_no}</span></p>
                <p>Target Amount: <span class="cap">${fundraiser.currency} ${fundraiser.targetAmount}</span></p>
                <p>Attachment:
                    ${fundraiser.attachmentUrl ? 
                        `<a href="${fundraiser.attachmentUrl}" target="_blank">View Document</a>` : 
                        'No attachment available'}
                </p>
                <p>Photos:
                    ${fundraiser.photos ? 
                        `<a href="${fundraiser.photos}" target="_blank">View Photos</a>` : 
                        'No photos available'}
                </p>
            </div>
            <div class="fundraiser-actions row">
                <button class="button button-update" onclick="openEditPopup(
                    '${fundraiser.id}', '${fundraiser.title}', '${escapeHtml(fundraiser.description)}',
                    '${fundraiser.category}', '${fundraiser.contact_no}', '${fundraiser.targetAmount}',
                    '${fundraiser.currency}', '${fundraiser.datetime}', '${fundraiser.photos}',
                    '${fundraiser.attachmentUrl}')">
                    <i class="fa-solid fa-pen-to-square"></i> Edit
                </button>
                <button class="button button-delete" onclick="confirmDelete('${fundraiser.id}')">
                    <i class="fa-solid fa-trash"></i> Delete
                </button>
            </div>
        `;
        fundraiserList.appendChild(fundraiserItem);
    });
}

// Set up sidebar toggle functionality
function setupSidebar() {
    const sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    
    sideMenuBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            body.classList.toggle("sidebar-collapsed");
        });
    });
}

// Set up form submission
function setupForm() {
    const editForm = document.getElementById('editFundraiserForm');
    
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form data
            const formData = new FormData(this);
            const fundraiserId = formData.get('fundraiserId');
            
            // In a real app, you would send this to a server
            console.log('Updating fundraiser:', fundraiserId, Object.fromEntries(formData));
            
            // Show success message
            alert('Fundraiser updated successfully!');
            
            // Close the popup
            closeEditPopup();
            
            // In a real app, you would refresh the data
            // refreshFundraisers();
        });
    }
}

// Open the edit popup with fundraiser data
function openEditPopup(fundraiserId, title, description, category, contactNo, targetAmount, currency, datetime, photos, attachmentUrl) {
    console.log("Opening edit popup for:", fundraiserId, title);
    
    const popup = document.getElementById('editPopup');
    if (popup) {
        popup.style.display = 'flex';
    }
    
    // Fill the form with the fundraiser data
    document.getElementById('fundraiserId').value = fundraiserId || '';
    document.getElementById('editTitle').value = title || '';
    document.getElementById('editDescription').value = description || '';
    document.getElementById('editContactNo').value = contactNo || '';
    document.getElementById('editCategory').value = category || '';
    document.getElementById('editTargetAmount').value = targetAmount || '';
    document.getElementById('editCurrency').value = currency || '';
    document.getElementById('editAttachmentUrl').value = attachmentUrl || '';
    document.getElementById('editPhotoUrl').value = photos || '';
}

// Close the edit popup
function closeEditPopup() {
    const popup = document.getElementById('editPopup');
    if (popup) {
        popup.style.display = 'none';
    }
}

// Filter fundraisers based on search input
function filterFundraisers() {
    const searchInput = document.getElementById('searchInput').value.toLowerCase();
    const fundraiserItems = document.querySelectorAll('.fundraiser-item');
    
    fundraiserItems.forEach(item => {
        const title = item.querySelector('.fundraiser-header .title')?.textContent.toLowerCase() || '';
        const description = item.querySelector('.fundraiser-content')?.textContent.toLowerCase() || '';
        
        if (title.includes(searchInput) || description.includes(searchInput)) {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });
}

// Confirm before deleting a fundraiser
function confirmDelete(fundraiserId) {
    if (confirm('Are you sure you want to delete this fundraiser? This action cannot be undone.')) {
        // In a real app, you would send a request to the server
        console.log('Deleting fundraiser:', fundraiserId);
        
        // Remove from UI
        const itemToRemove = document.querySelector(`.fundraiser-item [data-id="${fundraiserId}"]`)?.closest('.fundraiser-item');
        if (itemToRemove) {
            itemToRemove.remove();
        }
        
        alert('Fundraiser deleted successfully.');
    }
}

// Helper function to escape HTML
function escapeHtml(unsafe) {
    return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// Initialize Font Awesome icons
document.addEventListener('DOMContentLoaded', function() {
    // This would be handled by the Font Awesome auto-replacement in a real app
    console.log('Document loaded, icons should be visible');
});