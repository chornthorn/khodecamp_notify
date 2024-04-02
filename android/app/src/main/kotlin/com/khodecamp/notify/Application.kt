package com.khodecamp.notify

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.loader.FlutterLoader

class Application : FlutterApplication() {
    override fun onCreate() {
        this.createChannel();
        super.onCreate();
        FlutterLoader.Settings()
    }
    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Create the NotificationChannel
            val name = getString(R.string.default_notification_channel_id)
            val channel = NotificationChannel(name, "default", NotificationManager.IMPORTANCE_HIGH)
            val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
}
