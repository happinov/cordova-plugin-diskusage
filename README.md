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

## 1.0.0
  * Initial release supporting both iOS and Android.
