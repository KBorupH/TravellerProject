importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');

const firebaseConfig = {
    apiKey: "AIzaSyBcEj68F_jBw6B06vEguWiq8SEAayMWtJg",
    authDomain: "traveller-35de6.firebaseapp.com",
    projectId: "traveller-35de6",
    storageBucket: "traveller-35de6.appspot.com",
    messagingSenderId: "713539644947",
    appId: "1:713539644947:web:9ee1969f6cf6a4ea40d9e6",
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();
messaging.onBackgroundMessage((payload) => {
    console.log(
        '[firebase-messaging-sw.js] Received background message ',
        payload
    );
    // Customize notification here
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        icon: '/favicon.png'
    };

    self.registration.showNotification(notificationTitle, notificationOptions);
});