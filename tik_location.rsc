# 2024-07-21 17:40:12 by RouterOS 7.15.2
# software id = JUE8-IA5M
#
# model = RB912R-2nD
# serial number = B85C0A34B6E3
/system script
add dont-require-permissions=no name=mqttgps owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=" \
    \_  ###Configuration###\r\
    \n\r\
    \n    ###Set Callsign###\r\
    \n    :global call\r\
    \n    :set call \"\$[/system/id get name]\"\r\
    \n    #Enter pre-configured broker's name within \"\":\r\
    \n    :local broker \"Mosquitto\"\r\
    \n    #Enter the topic name within \"\", per the broker's configuration:\r\
    \n    :local topic \"v1/devices/\$call/telemetry\"\r\
    \n\r\
    \n    ###Variables####\r\
    \n    :global lat\r\
    \n    :global lon\r\
    \n    :global alt1\r\
    \n    :global alt2\r\
    \n\r\
    \n    ###GPS####\r\
    \n    :put (\"[*] Capturing GPS coordinates...\")\r\
    \n    /system gps monitor once do={\r\
    \n    :set \$lat \$(\"latitude\");\r\
    \n    :set \$lon \$(\"longitude\");\r\
    \n    :set \$alt1 \$(\"altitude\")}\r\
    \n    ###remove \"meters\" from the value because JSON format will not und\
    erstand it###\r\
    \n    :set \$alt2 [:pick \$alt1 0 [find \$alt1 \" m\"]]\r\
    \n\r\
    \n    :local message \\\r\
    \n    \"{\\\"latitude\\\":\$lat,\\\r\
    \n    \\\"longitude\\\":\$lon,\\\r\
    \n    \\\"altitude\\\":\$alt2,\\\
    \n    \\\"callsign\\\":\$call}"\r\
    \n\r\
    \n    ###MQTT###\r\
    \n    :if (\$lat != \"none\") do={\\\r\
    \n    :put (\"[*] Sending message to MQTT broker...\");\r\
    \n    /iot mqtt publish broker=\$broker topic=\$topic message=\$message} e\
    lse={:put (\"[*] Lattitude=none, not posting anything!\");:log info \"Lati\
    tude=none, not posting anything!\"}"
