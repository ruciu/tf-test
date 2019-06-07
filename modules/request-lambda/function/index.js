var AWS = require('aws-sdk');
AWS.config.update({region: 'eu-west-3'});
const dynamoDB = new AWS.DynamoDB({apiVersion: '2012-08-10'});

exports.handler = function(event, context, callback) {
    const body = JSON.parse(event.body);
    const params = {
        TableName: 'Email',
        Item: {
            'Name' : { S: body.name },
            'Email' : { S: body.email },
            'Message': { S: body.message }
        }
    };

    dynamoDB.putItem(params, function(err, data) {
        if (err) {
            callback(null, {
                statusCode: 500,
                body: JSON.stringify(err),
            })
        } else {
            console.log("Success", data);
            callback(null, {
                statusCode: 200,
                body: JSON.stringify(data)
            })
        }
    });
}