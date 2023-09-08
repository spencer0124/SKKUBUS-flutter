package com.zoyoong.skkumap

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", "transparent")
        super.onCreate(savedInstanceState)
    }
}
