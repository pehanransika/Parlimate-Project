/**
 * Formats a datetime string into HTML elements with date and time
 * @param {string} datetimeStr - The datetime string (e.g., "2025-04-25 14:06:57.489")
 * @returns {string} HTML string with formatted date and time
 */
function formatDateTime(datetimeStr) {
    // Parse the datetime string
    const dateObj = new Date(datetimeStr.replace(' ', 'T')); // Convert to ISO format

    // Format date as YYYY-MM-DD
    const dateStr = datetimeStr.split(' ')[0];

    // Format time as 12-hour with AM/PM
    const hours = dateObj.getHours();
    const minutes = dateObj.getMinutes();
    const ampm = hours >= 12 ? 'PM' : 'AM';
    const formattedHours = hours % 12 || 12; // Convert 0 to 12
    const formattedMinutes = minutes.toString().padStart(2, '0');
    const timeStr = `${formattedHours}:${formattedMinutes} ${ampm}`;

    // Return the HTML structure
    return `
        <span class="date">${dateStr}</span>
        <span class="dot"></span>
        <span class="time">${timeStr}</span>
    `;
}

// Apply to all post dates when page loads
document.addEventListener('DOMContentLoaded', function() {
    // Format dates in posts
    document.querySelectorAll('.formatDate').forEach(container => {
        const dateElement = container.querySelector('.date');
        if (dateElement) {
            const originalDate = dateElement.textContent.trim();
            if (originalDate) {
                container.innerHTML = formatDateTime(originalDate);
            }
        }
    });

    // Format time in popup if needed
    const popupTime = document.getElementById('popup-time');
    if (popupTime) {
        const originalDate = popupTime.textContent.trim();
        if (originalDate) {
            const formatted = formatDateTime(originalDate);
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = formatted;
            popupTime.textContent = tempDiv.querySelector('.time').textContent;
        }
    }
});