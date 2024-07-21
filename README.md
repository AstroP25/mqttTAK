# mqttTAK
Repository aims at converting MQTT telemetry messages to CoT to publish to a TAKServer using scripting on embeded LTE devices (such as Mikortik LtAP and Knot series) or other devices that can publish JSON messages to a MQTT broker thus allowing IoT devices to push AVL information into a TAK Server without using ATAK, WinTAK, or iTAK.

The premise for this was introduced as a question on Bridge4PS's "Tech Club - TAK" channel by a Texas Parks and Wildlife Department (TPWD) employee looking for solutions for tracking swiftwater rescue assets. Currently, members representing Texas Department of Public Safety (TxDPS), Austin-Travis EMS (ATEMS), Western Region Radio System (WRRS), Washington Emergency Management Division, Pender EMS & Fire, North Carolina Depatment of IT, Kanasas Turnpike Authority, and South Orange Rescue have been collaborating on possible solutions.

## Mikrotik Location Script
This script provides the tooling to configure a Mikroitk Roouter OS device to send GPS information to a MQTT Broker.
### Prerequesites:
- GPS and IoT packages must be installed
- MQTT Broker (tested with Mosquitto 2.0.18)