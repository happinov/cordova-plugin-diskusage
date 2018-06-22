var DiskUsagePlugin = {
	pluginClass: 'DiskUsagePlugin',

	read: function(successCallback, errorCallback){
		cordova.exec(successCallback, errorCallback, DiskUsagePlugin.pluginClass, 'read',[]);
	}
};

module.exports = DiskUsagePlugin;
