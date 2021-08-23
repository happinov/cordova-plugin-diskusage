# Disk Usage Plugin for Cordova

## Description
This plugin allows you to get total and free disk space on your device.

On Android it only supports internal storage for now.

*Note:* Minimum andoid SDK is 18.

## Usage

```
DiskUsage.read(function(result){
  console.log("total:",result.internal.total);
  console.log("free:",result.internal.free);
});
```

## License
This code is released under the [MIT license](LICENSE).

## Changelog

## 2.1.1
  * Fixed values returned on ios.

## 2.1.0
  * Removed add-swift-support plugin dependency.

## 2.0.0
  * Updated code for swift 4.2.

## 1.0.0
  * Initial release supporting both iOS and Android.
