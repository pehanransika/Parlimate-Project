function processHashtags() {
    // Get all post content elements
    const postContents = document.querySelectorAll('.hashtags');

    postContents.forEach(content => {
        // Replace hashtags with styled spans
        content.innerHTML = content.innerHTML.replace(
            /#(\w+)/g,
            '<span class="hashtag">#$1</span>'
        );
    });
}
