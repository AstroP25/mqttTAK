# mqttTAK
Repository aims at converting MQTT telemetry messages to CoT to publish to a TAKServer using scripting on embeded LTE devices (such as Mikortik LtAP and Knot series) or other devices that can publish JSON messages to a MQTT broker thus allowing IoT devices to push AVL information into a TAK Server without using ATAK, WinTAK, or iTAK.

The premise for this was introduced as a question on Bridge4PS's "Tech Club - TAK" channel by a Texas Parks and Wildlife Department (TPWD) employee looking for solutions for tracking swiftwater rescue assets. Currently, members representing Texas Department of Public Safety (TxDPS), Austin-Travis EMS (ATEMS), Western Region Radio System (WRRS), Washington Emergency Management Division, Pender EMS & Fire, North Carolina Depatment of IT, Kanasas Turnpike Authority, and South Orange Rescue have been collaborating on possible solutions.

## Mikrotik Location Script
This script provides the tooling to configure a Mikroitk Roouter OS device to send GPS information to a MQTT Broker.
### Prerequesites:
- GPS and IoT packages must be installed
- MQTT Broker (tested with Mosquitto 2.0.18)

## Node RED
Node RED is used to convert the JSON message from the MQTT Broker to CoT XML which is then sent to the TAK Server. The output can also be pushed via multicast for use without a TAK server on the local network (or maybe you are taking advantage of multicast routing). The flow JSON file is included but you will need to install the node-red-contrib-tak nodes in your instance of Node RED.