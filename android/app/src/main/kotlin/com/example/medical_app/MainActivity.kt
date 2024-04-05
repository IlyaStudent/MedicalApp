package com.example.medical_app

import io.flutter.embedding.android.FlutterActivity
import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity()

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setApiKey("29be3848-ddd8-403f-8ade-33281bd72ce2") // Your generated API key
  }
}
