document.addEventListener('DOMContentLoaded', function() {
    console.log("Profile page loaded");
    initializePostLoading();
    setupModalHandlers();
    initializeCityDropdown();
});

// Main post loading functionality
function initializePostLoading() {
    // Safely get user ID from data attribute
    const container = document.getElementById('posts-container');
    const userId = container.dataset.userId || '${userProfile.userId}'; // Fallback to JSP var

    if (!userId || userId === 'null') {
        showError("User profile not available. Please refresh the page.");
        return;
    }

    // Show loading state
    container.innerHTML = '<div class="loading-spinner">Loading posts...</div>';

    // Start loading posts
    fetchPosts(userId);
}

async function fetchPosts(userId) {
    try {
        console.log(`Fetching posts for user ${userId}`);
        const startTime = Date.now();

        // Use a more reliable way to construct the URL
        const url = new URL('/Parlimate/GetUserPostsServlet', window.location.origin);
        url.searchParams.append('userId', userId);
        url.searchParams.append('t', Date.now()); // Cache buster

        const response = await fetch(url.toString());
        const responseTime = Date.now() - startTime;

        console.log(`Request completed in ${responseTime}ms`, response);

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Server responded with ${response.status}: ${errorText}`);
        }

        const posts = await response.json();
        console.log("Parsed posts:", posts);

        if (!Array.isArray(posts)) {
            throw new Error("Expected array of posts but got: " + typeof posts);
        }

        if (posts.length === 0) {
            showMessage("No posts found for this user");
        } else {
            renderPosts(posts);
        }

    } catch (error) {
        console.error("Post loading failed:", {
            error: error,
            message: error.message,
            stack: error.stack
        });
        showError(`Failed to load posts. ${error.message}`);
    }
}

function renderPosts(posts) {
    const container = document.getElementById('posts-container');

    container.innerHTML = posts.map(post => `
        <div class="post-card">
            <div class="post-header">
                <img src="https://i.pravatar.cc/50?u=${post.userId}" 
                     alt="User avatar" 
                     class="post-avatar">
                <div class="post-user-info">
                    <h4>${escapeHtml(post.name || 'Unknown User')}</h4>
                    <span>${formatDate(post.datetime)}</span>
                </div>
            </div>
            <div class="post-content">
                <p>${escapeHtml(post.content || '')}</p>
            </div>
            <div class="post-footer">
                <button class="action-btn like-btn">
                    <i class="fa-regular fa-thumbs-up"></i>
                    <span>0</span>
                </button>
                <button class="action-btn comment-btn">
                    <i class="far fa-comment"></i> <span>0</span>
                </button>
                <button class="action-btn share-btn">
                    <i class="fas fa-share"></i> <span>Share</span>
                </button>
            </div>
        </div>
    `).join('');
}

// Modal handling functions
function setupModalHandlers() {
    const editBtn = document.querySelector(".edit-btn");
    const modal = document.getElementById("editModal");
    const closeBtn = document.querySelector(".close-btn");
    const modalCancelBtn = document.getElementById("cancel-btn");

    modal.style.display = "none";

    editBtn?.addEventListener("click", () => modal.style.display = "flex");
    closeBtn?.addEventListener("click", () => modal.style.display = "none");
    modalCancelBtn?.addEventListener("click", () => modal.style.display = "none");

    window.addEventListener("click", (event) => {
        if (event.target === modal) modal.style.display = "none";
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

    provinceSelect?.addEventListener("change", function() {
        const selectedProvince = this.value;
        citySelect.innerHTML = "";

        if (selectedProvince) {
            citySelect.disabled = false;
            citySelect.add(new Option("-- Select City --", ""));
            citiesByProvince[selectedProvince].forEach(city => {
                citySelect.add(new Option(city, city.toLowerCase().replace(" ", "-")));
            });
        } else {
            citySelect.disabled = true;
            citySelect.add(new Option("-- First select a province --", ""));
        }
    });
}

// Utility functions
function escapeHtml(unsafe) {
    return unsafe ? unsafe.toString()
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;") : '';
}

function formatDate(timestamp) {
    if (!timestamp) return "Recently";
    try {
        const date = new Date(timestamp);
        return date.toLocaleString();
    } catch (e) {
        console.error("Date formatting error:", e);
        return "Recently";
    }
}

function showMessage(message) {
    const container = document.getElementById('posts-container');
    container.innerHTML = `<div class="info-message">${message}</div>`;
}

function showError(message) {
    const container = document.getElementById('posts-container');
    container.innerHTML = `
        <div class="error-message">
            ${message}
            <button onclick="initializePostLoading()">Retry</button>
        </div>
    `;
}

// Make functions available for HTML onclick handlers
window.fetchPosts = fetchPosts;
window.initializePostLoading = initializePostLoading;