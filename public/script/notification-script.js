window.addEventListener('load', async function () {
    // manage notifications
    const notificationBell = document.querySelector('.bell-icon');

    const userNotifications = await getAllNotifications();
    console.log(userNotifications);
    setNotificationDropDownMenu();

    // manage bell icon
    const notifUnreadTag = document.querySelector(
        '.notification-amount > span'
    );
    const notifUnviewedTag = document.querySelector(
        '.notify-content p'
    );
    console.log(notifUnviewedTag.textContent)
    notificationBell.addEventListener('click', () => {
        deactivateBell();
        if (checkIfMoreThanZeroNotif()) setTimeout(activateBell, 100);
    });
    setNumberOfNotifications();
    if (checkIfMoreThanZeroNotif()) activateBell();

    // Bell Icon Functions
    function setNumberOfNotifications() {
        let readNotifNum = 0;
        let viewNotifNum = 0;
        for (notif of userNotifications) {
            if (notif.isRead === 0) readNotifNum++;
            if (notif.isViewed === 0) viewNotifNum++;
        }
        notifUnreadTag.textContent = readNotifNum;
        notifUnviewedTag.textContent = viewNotifNum;
    }

    function checkIfMoreThanZeroNotif() {
        if (parseInt(notifUnviewedTag.textContent) > 0) return true;
        else return false;
    }

    function activateBell() {
        notificationBell.classList.add('activate');
    }

    function deactivateBell() {
        notificationBell.classList.remove('activate');
    }

    // Notification Functions
    async function getAllNotifications() {
        const response = await fetch(`/api/get-all-notifications`);
        let data = makeArray(await response.json());
        if (data.length === 0) notifUnreadTag.textContent = 'No notifications';
        return data;
    }

    function setNotificationDropDownMenu() {
        const notifyDropMenu = document.querySelector('.notify-content');
        for (notification of userNotifications) {
            createNotification(notification);
        }

        function createNotification(indvNotif) {
            let divTag = document.createElement('div');
            divTag.classList.add('clicked');
            addLinkToNotificationDiv();
            checkAndUpdateIsRead();

            let p1Tag = document.createElement('p');
            p1Tag.classList.add('clicked');
            p1Tag.innerHTML = indvNotif.content;

            let p2Tag = document.createElement('p');
            p2Tag.classList.add('clicked');
            const localTime = new Date(indvNotif.time).toLocaleString(); // parse to local time
            p2Tag.innerHTML = `Time recieved: ${localTime}`;

            createTrashButton();

            divTag.appendChild(p1Tag);
            divTag.appendChild(p2Tag);
            notifyDropMenu.appendChild(divTag);

            function addLinkToNotificationDiv() {
                divTag.addEventListener('click', function (event) {
                    if (event.target.tagName.toLowerCase() !== 'img') {
                        const profileRoute = `/profile?id=${indvNotif.host_id}`;
                        const articleRoute = `/article/${indvNotif.article_id}`;
                        let route;
                        if (
                            indvNotif.type === 'like' ||
                            indvNotif.type === 'sub'
                        ) {
                            route = profileRoute;
                        } else if (
                            indvNotif.type === 'write' ||
                            'comment' ||
                            'reply'
                        ) {
                            route = articleRoute;
                        }
                        window.location.href = route;
                    }
                });
            }

            function checkAndUpdateIsViewed() {
                if (indvNotif.isViewed === 1) {
                    divTag.classList.add('read');
                }
                divTag.addEventListener('click', async function () {
                    if (indvNotif.isRead === 0) {
                        await fetch(`/api/update-isRead?id=${indvNotif.id}`);
                    }
                });
            }

            function checkAndUpdateIsRead() {
                notificationBell.addEventListener('click', async function () {
                    if (indvNotif.isViewed === 0) {
                        await fetch(`/api/update-isViewed?id=${indvNotif.id}`);
                    }
                });
            }

            function createTrashButton() {
                let svgImgTag = document.createElement('img');
                svgImgTag.classList.add('svg-trash', 'clicked');
                svgImgTag.setAttribute('src', '/images/svg/empty.svg');
                svgImgTag.setAttribute('alt', 'trash icon');
                divTag.appendChild(svgImgTag);

                svgImgTag.addEventListener('click', async (event) => {
                    // visually update
                    console.log('this is run right?');
                    const parentElement = event.target.parentElement;
                    if (parentElement) {
                        parentElement.remove();
                        if (!parentElement.classList.contains('read')) {
                            notifUnreadTag.textContent =
                                notifUnreadTag.textContent - 1;
                        }
                    }

                    // update database
                    const res = await fetch(
                        `/api/delete-notification?id=${indvNotif.id}`,
                        {
                            method: 'DELETE',
                        }
                    );
                    if (res.status === 204)
                        console.log('Notification deleted successfully');
                    else console.log('Error deleting notification');
                });
            }
        }
    }

    // MISC
    function makeArray(input) {
        if (input === undefined) {
            return [];
        } else if (Array.isArray(input)) {
            return input;
        } else {
            return [input];
        }
    }
});
