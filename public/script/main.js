window.addEventListener("load", function () {
    const dropdown = document.querySelector('.dropdown');
    const dropDownContent = document.querySelector('.dropdown-content');

    window.addEventListener('click', (e) => {
        if (!e.target.classList.contains('clicked')) {
            if (dropDownContent) {
                dropDownContent.style.display = 'none';
            }
        }
    });

    console.log("testing");
    if (dropdown) {
        dropdown.addEventListener('click', (e) => {
            if (e.target.classList.contains('clicked')) {
                dropDownContent.style.display = 'block';
            }
        });
    }
    
    console.log("i am here");


    const notifyDrop = document.querySelector('.notify-drop');
    const notifyContent = document.querySelector('.notify-content');
    let notifyClicked = false;

    window.addEventListener('click', (e) => {
        if (!e.target.classList.contains('clicked')) {
            if (notifyContent) {
                notifyContent.style.display = 'none';
                notifyClicked = false;
            }
        }
    });

    if (notifyDrop) {
        notifyDrop.addEventListener('click', (e) => {
            if (e.target.classList.contains('clicked')) {
                notifyContent.style.display = 'block';
                notifyClicked = true;
            }
        });
    }
    

    const calenderButton = document.querySelector("#search-calender")
    const calenderDiv = document.querySelector(".filterDiv")
    calenderButton.addEventListener(`click`, (e)=>{
        if(calenderDiv.style.display == "flex"){
            calenderDiv.style.display = "none"
        }else{
            calenderDiv.style.display = "flex"
        }
    })

    window.addEventListener('click', (e) => {
        console.log(e.target.id)
        if (e.target.id !== 'search-calender') {
            calenderDiv.style.display = "none";
        }
    })



});
