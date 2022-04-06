import * as mqtt from 'mqtt';
import * as sqlite_functions from '../sqliteFunctions/sqliteFunctions';
import * as common from '../commonFunctions/commom';
import * as nrp from '../routes/routes';

const options = {
    clientId: "data-access-api",
    username: "DataAccessApi",
    password: "pa$$w0rd",
    clean: false
};
var isConnected = false
var client:mqtt.MqttClient

function mqttinit(){
    if (isConnected == false) { 
        console.log("Connecting...\n")
        client  = mqtt.connect('mqtt://mqtt-broker:1883', options)
    }
    return client
}

function mqttprocess(client:mqtt.MqttClient){

    let message_split: string[]
    let topic_split:string[]
    let consumer_did:string
    let data_source_uid:string
    let timestamp:string
    let topic_subscribed_to:string
    let topic_unsubscribed_to:string
    let sub_id = 0
    let ammount_of_data_received = 0
    
    client.on('connect', function () {
        isConnected = true
	    console.log("Connected\n")
        client.subscribe('$SYS/broker/log/#')
    })

    client.on('message', async function (topic, message) {

        console.log(">>>>> "+topic +" " +message.toString())

        if (topic.startsWith("$SYS/broker/log/M/subscribe")) {

            message_split = message.toString().split(' ');
            topic_subscribed_to = message_split[3]
            timestamp = message_split[0]
            topic_split = message_split[3].split('/')
            consumer_did = topic_split[2]
            data_source_uid = topic_split[3]
        }

        if (topic.startsWith("$SYS/broker/log/M/unsubscribe")) {

            message_split = message.toString().split(' ');
            topic_unsubscribed_to = message_split[2]
            topic_split = message_split[2].split('/')
            consumer_did = topic_split[2]
            data_source_uid = topic_split[3]
        }

        if(topic.startsWith("$SYS/broker/log/M/subscribe") && topic_subscribed_to.startsWith("/to/" + consumer_did)){

            client.subscribe('/from/'+`${consumer_did}` + `/${data_source_uid}`)
   
            sqlite_functions.addSubscriberToDatabase(consumer_did, data_source_uid, timestamp.replace(':', ''), sub_id, ammount_of_data_received)
            sub_id = sub_id + 1
            const action = "subscribe"

  	        sqlite_functions.start_or_end_stream(data_source_uid, action)
        }

        if(topic.startsWith("$SYS/broker/log/M/unsubscribe") && topic_unsubscribed_to.startsWith("/to/" + consumer_did)){
            
            sqlite_functions.deleteConsumerSubscription(consumer_did, data_source_uid)
            client.unsubscribe('/from/'+`${consumer_did}` + `/${data_source_uid}`)
            const action = "unsubscribe"
            
            sqlite_functions.start_or_end_stream(data_source_uid, action)
            console.log(consumer_did + " unsubscribed!")

        }
        // Response to client logic here
        if (topic.startsWith('/from/')){
            let npProvider = nrp.getNpProvider()
            let por = JSON.parse(message.toString())
            const poP = await common.validateProofOfReception(por, npProvider)
            //common.NRPcompletenessCheck(npProvider)
            client.publish('/to/'+`${consumer_did}` + `/${data_source_uid}`, JSON.stringify(poP))
        }

    })
}

export default { mqttinit, mqttprocess }
