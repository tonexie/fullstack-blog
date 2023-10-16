window.addEventListener("load", function () {
    async function displaySubOption() {
        const user_id = document.querySelector("#user_id");
        const profile_id = document.querySelector('#profile_id');
        const profile_related_info = document.querySelector('#profile_related_info');
        if (user_id.value != profile_id.value) {
            const option = document.createElement("button");
            const isSubscribe = await checkIfSubscribe(user_id.value, profile_id.value);
            const subscription_id = profile_id.value;
            if (isSubscribe == 1) {
                option.innerHTML = `<img src="/images/unsubscribe.png">Unsubscribe`;
                option.addEventListener("click", function () {
                    removeSubscription(subscription_id);
                });
            } else if (isSubscribe == 0) {
                option.innerHTML = `<img src="/images/subscribe.png">Subscribe`;
                option.addEventListener("click", function () {
                    addSubscription(subscription_id);
                });
            }
            profile_related_info.appendChild(option);
        }
        
    }

    async function checkIfSubscribe(user_id, check_id) {
        const response = await fetch(`/api/checkIfSub`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ user_id, check_id }),
        });
        const isSubscribe = await response.text();
        return isSubscribe;
    }

    async function removeSubscription(subscription_id) {
        const subscriptionId = subscription_id;
        fetch(`/removeSubscription?id=${subscriptionId}`)
            .then(response => {
                if (response.status === 200) {
                    location.reload();
                } else {
                    console.error('Error removing subscription');
                }
            })
            .catch(error => {
                console.error('Network error:', error);
            });
    }

    async function addSubscription(subscription_id) {
        const subscriptionId = subscription_id;
        fetch(`/addSubscription?id=${subscriptionId}`)
            .then(response => {
                if (response.status === 200) {
                    location.reload();
                } else {
                    console.error('Error removing subscription');
                }
            })
            .catch(error => {
                console.error('Network error:', error);
            });
    }

    displaySubOption();

})
