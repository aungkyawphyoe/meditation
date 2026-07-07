package com.example.meditation

import android.util.Log
import com.google.android.gms.wearable.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class WearCommunicationPlugin private constructor(
    private val channel: MethodChannel,
    private val dataClient: DataClient,
) : DataClient.OnDataChangedListener {

    companion object {
        private const val TAG = "WearCommMobile"
        private const val CHANNEL = "com.example.meditation/communication"
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

                if (uri.path == PATH_SYNC) {
                    val dataMap = DataMapItem.fromDataItem(event.dataItem).dataMap
                    val beadCount = dataMap.getInt("beadCount")
                    val roundsCompleted = dataMap.getInt("roundsCompleted")
                    val mode = dataMap.getString("mode")

                    channel.invokeMethod("onSyncData", mapOf(
                        "beadCount" to beadCount,
                        "roundsCompleted" to roundsCompleted,
                        "mode" to mode,
                    ))
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
            "sendMode" -> {
                val args = call.arguments as Map<*, *>
                val mode = args["mode"] as String

                val request = PutDataMapRequest.create(PATH_MODE).apply {
                    dataMap.putString("mode", mode)
                }

                dataClient
                    .putDataItem(request.asPutDataRequest())
                    .addOnSuccessListener {
                        Log.d(TAG, "Mode sent: $mode")
                        result.success(true)
                    }
                    .addOnFailureListener { e ->
                        Log.e(TAG, "Failed to send mode", e)
                        result.error("SEND_FAILED", e.message, null)
                    }
            }
            else -> result.notImplemented()
        }
    }
}
