const AWS = require("aws-sdk");
const sns = new AWS.SNS();

exports.handler = function(event, context, callback) {
    event.Records.forEach((record) => {
        const newImage = record.dynamodb.NewImage;
        const name = newImage.Name.S;
        const email = newImage.Email.S;
        const message = newImage.Message.S;
        const params = {
            Subject: 'New event',
            Message: JSON.stringify(`${name} ${email} ${message}`),
            TopicArn: process.env.TOPIC_ARN
        };
        sns.publish(params, function(err, data) {
            if (err) {
                console.error("Unable to send message. Error JSON:", JSON.stringify(err, null, 2));
            } else {
                console.log("Results from sending message: ", JSON.stringify(data, null, 2));
            }
        });
    });
    callback(null, `Success`);
}