if (window.top === window) {
    registerPage();
    heartbeat();
}

function registerPage() {
    safari.extension.dispatchMessage("r");
}

function heartbeat() {
    registerPage();
    setTimeout(heartbeat, 3000);
}
