# mqttTAK
Repository aims at converting MQTT telemetry messages to CoT to publish to a TAKServer using scripting on embeded LTE devices (such as Mikortik LtAP and Knot series) or other devices that can publish JSON messages to a MQTT broker thus allowing IoT devices to push AVL information into a TAK Server without using ATAK, WinTAK, or iTAK.

The premise for this was introduced as a question on Bridge4PS's "Tech Club - TAK" channel by a Texas Parks and Wildlife Department (TPWD) employee looking for solutions for tracking swiftwater rescue assets. Currently, members representing Texas Department of Public Safety (TxDPS), Austin-Travis EMS (ATEMS), Western Region Radio System (WRRS), Washington Emergency Management Division, Pender EMS & Fire, North Carolina Depatment of IT, Kanasas Turnpike Authority, and South Orange Rescue have been collaborating on possible solutions.

## Mikrotik Location Script
This script provides the tooling to configure a Mikroitk Roouter OS device to send GPS information to a MQTT Broker.

Simply copy the script over to a Mikrotik device and import it using the import command '''import file=tik_location.rsc''' via the command line interface. Then create a schedule to execute the script at whatever interval you desire. Don't forget to configure your MQTT settings in Router OS accordingly. 
### Prerequesites:
- GPS and IoT packages must be installed
- MQTT Broker (tested with Mosquitto 2.0.18)

## Node RED
Node RED is used to convert the JSON message from the MQTT Broker to CoT XML which is then sent to the TAK Server. The output can also be pushed via multicast for use without a TAK server on the local network (or maybe you are taking advantage of multicast routing). The flow JSON file is included but you will need to install the node-red-contrib-tak nodes in your instance of Node RED.

To use, simply import "TAK_Location.json" into Node-RED, point the MQTT input node to the MQTT Broker, the TCP Out node to point at your TAK Server (uploading TLS creds as needed) and deploy the flow. There is a test injection node and function included to inject a test payload (simulated from a Mikrotik device configured with the "tik_location.rsc" script) into TAK by clicking the blue button to the left of the inject node. If interfaced to the TAK server correctly, a point should appear in a school parking lot in Burnet, TX. This point can be changed by simply changing the coordinates in the test function node.

## Notes
This was tested with TAK Server 5.1.0, Node-RED 4.0.2, mosquitto 2.0.18 and Mikrotik RouterOS v7.15.2. Both Node-RED and mosquitto were ran as Docker containers on a 2024 MacBook Air with the Apple M3 processor.

Docker Images:
- nodered/node-red:latest (-p 1880:1880/tcp)
- project25/mosquitto:2.0.18 (-p 1883:1883/tcp)