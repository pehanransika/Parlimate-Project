function processHashtags() {
    const postContents = document.querySelectorAll('.post-content p');

    postContents.forEach(content => {
        content.innerHTML = content.innerHTML.replace(
            /#(\w+)/g,
            '<span class="hashtag">#$1</span>'
        );
    });
}