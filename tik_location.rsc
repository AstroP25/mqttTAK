# 2024-07-23 08:40:27 by RouterOS 7.15.2
# software id = JRDD-WRMM
#
# model = RB924i-2nD-BT5&BG77
# serial number = F5830EAD8DFD
/system script
add dont-require-permissions=no name=mqttgps owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=" \
    \_  ###Configuration###\r\
    \n\r\
    \n    ###Set Callsign and Serial Number###\r\
    \n    :global call\r\
    \n    :global serialNumber\r\
    \n    :set \$call \"\$[/system/id get name]\"\r\
    \n    :set \$serialNumber \"\$[/system routerboard get value-name=serial-n\
    umber]\"\r\
    \n    #Enter pre-configured broker's name within \"\":\r\
    \n    :local broker \"Mosquitto\"\r\
    \n    #Enter the topic name within \"\", per the broker's configuration:\r\
    \n    :local topic \"v1/devices/mikrotik/\$call/telemetry\"\r\
    \n\r\
    \n    ###Variables####\r\
    \n    :global lat\r\
    \n    :global lon\r\
    \n    :global alt1\r\
    \n    :global alt2\r\
    \n    :global serialNumber\r\
    \n\r\
    \n    ###GPS####\r\
    \n    :put (\"[*] Capturing GPS coordinates...\")\r\
    \n    /system gps monitor once do={\r\
    \n    :set \$lat $("latitude");\r\
    \n    :set \$lon $("longitude");\r\
    \n    :set \$alt1 $("altitude")}\r\
    \n    ###remove \"meters\" from the value because JSON format will not und\
    erstand it###\r\
    \n    :set \$alt2 [:pick \$alt1 0 [find \$alt1 \" m\"]]\r\
    \n\r\
    \n    :local message \\\r\
    \n    \"{\\\"latitude\\\":\$lat,\\\r\
    \n    \\\"longitude\\\":\$lon,\\\r\
    \n    \\\"altitude\\\":\$alt2,\\\r\
    \n    \\\"callsign\\\":\\\"\$call\\\",\\\r\
    \n    \\\"sn\\\":\\\"\$serialNumber\\\"}\"\r\
    \n\r\
    \n    ###MQTT###\r\
    \n    :if (\$lat != \"none\") do={\\\r\
    \n    :put (\"[*] Sending message to MQTT broker...\");\r\
    \n    /iot mqtt publish broker=\$broker topic=\$topic message=\$message} e\
    lse={:put (\"[*] Lattitude=none, not posting anything!\");:log info \"Lati\
    tude=none, not posting anything!\"}"
