var apn = require('apn');
var express = require('express');
var bodyParser = require('body-parser')

const app = express()
app.use(bodyParser.json({limit: "1mb"}))

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

app.post('/spawnTrigger', (request, response) => {
    console.log(request.body)
    
    var triggerName = request.body["triggerName"]
    var alertText = request.body["alertText"]
    
    if (triggerName && alertText) {
        var notification = new apn.Notification();
        notification.badge = 1;
        notification.sound = "ping.aiff";
        notification.alert = alertText;
        notification.payload = {'triggerName': triggerName};
        notification.topic = "edu.gatech.triggerhunter.Trigger-Hunter-AR.cal-stephens";

        apnProvider.send(notification, deviceToken)
        response.send({'success': true})
    } else {
        response.send({'success': false})
    }
})

app.listen(8081)

/*
*/