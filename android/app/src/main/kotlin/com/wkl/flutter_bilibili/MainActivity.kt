package com.wkl.flutter_bilibili

import android.os.Bundle

import io.flutter.embedding.android.FlutterActivity
import com.umeng.analytics.MobclickAgent
import com.umeng.commonsdk.UMConfigure

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        UMConfigure.init(this, "60cf1e5626a57f10182e89ba", "Flutter BiliBili", UMConfigure.DEVICE_TYPE_PHONE, null)
    }

    override fun onPause() {
        super.onPause()
        MobclickAgent.onPause(this)
    }

    override fun onResume() {
        super.onResume()
        MobclickAgent.onResume(this)
    }
}
