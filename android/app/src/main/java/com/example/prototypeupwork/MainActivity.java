package com.example.prototypeupwork;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.StrictMode;

import android.support.v4.content.FileProvider;
import android.util.Log;
import java.io.File;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "team.native.io/screenshot";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    StrictMode.VmPolicy.Builder builder = null;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
      builder = new StrictMode.VmPolicy.Builder();
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
      StrictMode.setVmPolicy(builder.build());
    }
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
        new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall call, Result result) {
            Log.d("ANDROID NATIVE",
                "onMethodCall: call=" + call.method + ", args=" + call.arguments.toString());
            if (call.method.equals("takeScreenshot")) {
              String filePath = call.argument("filePath").toString();
              File file = new File(filePath);
              Uri fileShareableUri = FileProvider.getUriForFile(MainActivity.this,
                  "com.example.prototypeupwork.fileprovider", file);
              final Intent shareIntent = new Intent(Intent.ACTION_SEND);
              shareIntent.setType("image/jpg");
              shareIntent.putExtra(Intent.EXTRA_STREAM, fileShareableUri);
              startActivity(Intent.createChooser(shareIntent, "Share image using"));
              result.success("Done");
            } else {
              result.notImplemented();
            }
          }
        });
  }
}
