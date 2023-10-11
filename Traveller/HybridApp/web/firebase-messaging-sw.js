importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "...",
  authDomain: "...",
  databaseURL: "...",
  projectId: "...",
  storageBucket: "...",
  messagingSenderId: "...",
  appId: "...",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
       console.log('setBackgroundMessageHandler background message ', payload);

       const promiseChain = clients
          .matchAll({
              type: "window",
              includeUncontrolled: true
          })
         .then(windowClients => {
              for (let i = 0; i < windowClients.length; i++) {
                 const windowClient = windowClients[i];
                 windowClient.postMessage(payload);
              }
         })
         .then(() => {
              return self.registration.showNotification("my notification title");
          });
         return promiseChain;
     });