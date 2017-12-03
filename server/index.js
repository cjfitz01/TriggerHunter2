var apn = require('apn');

var options = {
  token: {
    key: "apns_key.p8",
    keyId: "H63F7Z8VZ6",
    teamId: "FZ89A5SZ7C" // Cal Stephens
  },
  production: false
};

var apnProvider = new apn.Provider(options);
var deviceToken = "05d5d57f23e6fa9f64c09f38b143a4c396ee7e4b6ab36844221db83aa4336a1c"

var notification = new apn.Notification();
notification.badge = 1;
notification.sound = "ping.aiff";
notification.alert = "Watch out, a dust mite just spawned in your bedroom!";
notification.payload = {'triggerName': 'Smoke'};
notification.topic = "edu.gatech.triggerhunter.Trigger-Hunter-AR.cal-stephens";

apnProvider.send(notification, deviceToken)