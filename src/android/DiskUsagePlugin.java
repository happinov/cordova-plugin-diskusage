package fr.happinov.cordova.plugin.diskusage;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.Environment;
import android.os.StatFs;
import android.util.Log;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class DiskUsagePlugin extends CordovaPlugin {
	private static final String TAG = DiskUsagePlugin.class.getSimpleName();

	private static final String FREE_KEY = "free";
	private static final String TOTAL_KEY = "total";

	private static final String INTERNAL_KEY = "internal";
	private static final String EXTERNAL_KEY = "external";

	public DiskUsagePlugin() {
	}

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("read"))
			readDiskData(callbackContext);
		else
			return false;

		return true;
	}

	private void readDiskData(CallbackContext callbackContext) throws JSONException {
		JSONObject result = new JSONObject();
		result.put(INTERNAL_KEY,getStorageData(Environment.getDataDirectory()));

		if (isExternalStorageAvailable())
			result.put(EXTERNAL_KEY,getStorageData(Environment.getExternalStorageDirectory()));

		Log.d(TAG,"Sending result:"+result);

		callbackContext.success(result);
	}

	private static boolean isExternalStorageAvailable() {
		//return Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED);
		return false; // Don't allow external storage support for now since it's broken.
	}

	private static JSONObject getStorageData(File refFile) throws JSONException {
		Log.d(TAG,"Getting storage data:"+refFile.getPath());
		JSONObject result = new JSONObject();

		StatFs stat = new StatFs(refFile.getPath());

		result.put(FREE_KEY,stat.getAvailableBytes());
		result.put(TOTAL_KEY,stat.getTotalBytes());

		return result;
	}
}
