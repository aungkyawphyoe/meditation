package com.example.meditation.wear

import android.util.Log
import com.google.android.gms.wearable.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit

class WearCommunicationPlugin private constructor(
    private val channel: MethodChannel,
    private val dataClient: DataClient,
) : DataClient.OnDataChangedListener {

    companion object {
        private const val TAG = "WearComm"
        private const val CHANNEL = "com.example.meditation.wear/communication"
        private const val PATH_MODE = "/meditation/mode"
        private const val PATH_SYNC = "/meditation/sync"

        fun registerWith(engine: FlutterEngine) {
            val context = engine.applicationContext
            val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
            val dataClient = Wearable.getDataClient(context)
            val plugin = WearCommunicationPlugin(channel, dataClient)
            channel.setMethodCallHandler(plugin)
            dataClient.addListener(plugin)
        }
    }

    override fun onDataChanged(dataEvents: DataEventBuffer) {
        for (event in dataEvents) {
            if (event.type == DataEvent.TYPE_CHANGED) {
                val uri = event.dataItem.uri
                Log.d(TAG, "DataItem changed: ${uri.path}")

                if (uri.path == PATH_MODE) {
                    val mode = DataMapItem.fromDataItem(event.dataItem).dataMap.getString("mode")
                    if (mode != null) {
                        channel.invokeMethod("onModeUpdate", mode)
                    }
                }
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "init" -> {
                Log.d(TAG, "init called")
                result.success(true)
            }
            "sendSyncData" -> {
                val args = call.arguments as Map<*, *>
                val beadCount = args["beadCount"] as Int
                val roundsCompleted = args["roundsCompleted"] as Int
                val mode = args["mode"] as String

                val request = PutDataMapRequest.create(PATH_SYNC).apply {
                    dataMap.putInt("beadCount", beadCount)
                    dataMap.putInt("roundsCompleted", roundsCompleted)
                    dataMap.putString("mode", mode)
                }

                dataClient
                    .putDataItem(request.asPutDataRequest())
                    .addOnSuccessListener {
                        Log.d(TAG, "Sync data sent successfully")
                        result.success(true)
                    }
                    .addOnFailureListener { e ->
                        Log.e(TAG, "Failed to send sync data", e)
                        result.error("SEND_FAILED", e.message, null)
                    }
            }
            else -> result.notImplemented()
        }
    }
}
