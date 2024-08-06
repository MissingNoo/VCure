if (instance_exists(oClient)) {
	sendMessage(0, {command : Network.Disconnect});
    network_destroy(oClient.client);
	network_destroy(oClient.connected);
}
Save_Data_Structs();