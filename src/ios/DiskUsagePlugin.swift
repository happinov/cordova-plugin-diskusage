
@objc(DiskUsagePlugin) class DiskUsagePlugin:CDVPlugin {
    func getRemainingFreeSpace() -> (free: Int64, total: Int64)? {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        guard
            let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
            let freeSize = systemAttributes[.systemFreeSize] as? NSNumber,
            let totalSize = systemAttributes[.systemSize] as? NSNumber
        else {
            // Something failed.
            return nil
        }
        
        return (free: freeSize.int64Value, total: totalSize.int64Value)
    }
    
	func read(_ command: CDVInvokedUrlCommand) {
        if let diskSize = getRemainingFreeSpace() {
            let message = [
                "internal": [
                    "free": diskSize.free,
                    "total": diskSize.total
                ]
            ]
            
            let result = CDVPluginResult(status:CDVCommandStatus_OK, messageAs:message)
            commandDelegate.send(result,callbackId:command.callbackId)
        } else {
            // Error reading disk status.
            let result = CDVPluginResult(status:CDVCommandStatus_ERROR, messageAs:"Error reading disk usage.")
            commandDelegate.send(result,callbackId:command.callbackId)
        }
	}
}
