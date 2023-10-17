window.addEventListener("load", async function () { await setUpQuillEditor(); });

async function setUpQuillEditor() {
    const toolBox = [
        [{ header: [1, 2, 3, false] }],
        ['bold', 'italic', 'underline', 'strike'],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
        [{ 'color': [] }, { 'background': [] }],
        [{ 'font': [] }],
        [{ 'align': [] }],
        ['clean']
        // ['image', 'code-block']
    ];

    const quill = new Quill('#update_article_content', {
        modules: {
            toolbar: toolBox
        },
        scrollingContainer: '#scrolling-container',
        placeholder: 'Compose an epic...',
        theme: 'snow'  // or 'bubble'
    });

    // fetch article content
    const content_delta_obj = await fetchArticleDelta();

    //set content at the editor
    const delta_response = quill.setContents(content_delta_obj, "api");

    if (!delta_response) {
        quill.setText('Unable to load your content\n');
    }

    const form = document.querySelector('#write_article_form');

    form.addEventListener('submit', async function (e) {
        e.preventDefault();

        // Populate hidden form on submit
        const content = document.querySelector('input[name=update_article_content]');
        content.value = JSON.stringify(quill.getContents());

        const title = document.getElementById("update_article_title").value;
        const genre = document.getElementById("update_article_genre").value;
        const article_id = document.getElementById("article_id_temp_storage").value;
        const image = document.getElementById("update_article_image").files[0];

        console.log(image)
        const actualContent = content.value;

        const formData = new FormData();
        formData.append("article_id_key", article_id)
        formData.append("titleKey", title);
        formData.append("genreKey", genre);
        formData.append("contentKey", actualContent);
        formData.append("imageKey", image);

        try {
            const response = await fetch('/api/updateArticle', {
                method: 'POST',
                body: formData
            });

            const responseData = await response.text();

            if (!response.ok) {
                throw new Error('Request failed with status: ' + response.status + " " + responseData);
            }

            //remove user input from text editor
            quill.deleteText(0, quill.getLength());
            //remove other user input
            document.getElementById("update_article_title").value = "";

            // Handle the response from the server
            alert(responseData + ' URL after response:' + window.location.href);


        } catch (error) {
            // Handle any errors that occur during the request
            alert(error + ". Potential cause: Image uploading is not supported yet.");
            //remove user input from text editor
            quill.deleteText(0, quill.getLength());
            //remove other user input
            document.getElementById("update_article_title").value = "";
        }

        const directTimer = setTimeout(() => {
            window.location.assign(`/editArticle/${article_id}`);
            clearTimeout(directTimer);
        }, 500);
    });
}

async function fetchArticleDelta() {
    const article_id = document.getElementById("article_id_temp_storage").value;
    const title_input = document.getElementById("update_article_title");
    const genere_select = document.getElementById("update_article_genre");


    const response = await fetch(`/api/currentEditArticleDelta?article_id=${article_id}`);
    const article = await response.json();

    title_input.value = article[0].title;

    //setting article current genre
    for (let i, j = 0; i = genere_select.options[j]; j++) {
        if (i.value == article[0].genre) {
            genere_select.selectedIndex = j;
            break;
        }
    }

    const content_delta = article[0].content_delta;
    const content_delta_json = JSON.parse(content_delta);
    return content_delta_json;
};