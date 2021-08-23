
@objc(DiskUsagePlugin) class DiskUsagePlugin:CDVPlugin {
    var totalDiskSpaceInBytes:Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }

    var freeDiskSpaceInBytes:Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }

	@objc func read(_ command: CDVInvokedUrlCommand) {
        let message = [
            "internal": [
                "free": freeDiskSpaceInBytes,
                "total": totalDiskSpaceInBytes
            ]
        ]

        let result = CDVPluginResult(status:CDVCommandStatus_OK, messageAs:message)
        commandDelegate.send(result,callbackId:command.callbackId)
	}
}
