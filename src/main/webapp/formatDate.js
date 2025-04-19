function formatDate(dateTimeString) {
    // Parse the input string into a Date object
    const date = new Date(dateTimeString);

    // Option 4: Custom format "Apr 18, 2025"
    const formatted4 = date.toLocaleString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        // hour: 'numeric',
        // minute: '2-digit',
        // hour12: true
    });

    return formatted4; // or return whichever format you prefer
}
function  formatDateWithTime(dateTimeString)  {
    const date = new Date(dateTimeString)
    const formatted = date.toLocaleString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: 'numeric',
        minute: '2-digit',
        hour12: true
    });

    return formatted;
}