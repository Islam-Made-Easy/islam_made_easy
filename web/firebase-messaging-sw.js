importScripts('/__/firebase/8.4.1/firebase-app.js')
importScripts('/__/firebase/8.4.1/firebase-messaging.js')
importScripts('/__/firebase/init.js')

const messaging = firebase.messaging()

messaging.setBackgroundMessageHandler(function (payload){
    title = payload.title;
    options = {
        body: payload.body,
        icon: '/icons/icon-512.png',
        badge: '/icons/icon-192.png'
    };
    return self.registration.showNotification(title, options);
});