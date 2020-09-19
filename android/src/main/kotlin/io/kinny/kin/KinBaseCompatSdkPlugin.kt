package io.kinny.kin

import android.app.Activity
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.util.Log

import kin.sdk.Environment
import kin.sdk.KinAccount
import kin.sdk.KinClient
import kin.sdk.exception.CreateAccountException

/** KinBaseCompatSdkPlugin */
public class KinBaseCompatSdkPlugin(activity: Activity) : FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity;

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "kin_base_compat_sdk")
    channel.setMethodCallHandler(this);
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "kin_base_compat_sdk")
      channel.setMethodCallHandler(KinBaseCompatSdkPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if(call.method == "createAccount"){
      var kinClient = KinClient(activity, Environment.TEST, "1acd")
      var account: KinAccount
      try {
          if (!kinClient.hasAccount()) {
              account = kinClient.addAccount()
              Log.i("INFO - base- compat", account.publicAddress)

          }
      } catch (e: CreateAccountException) {
          e.printStackTrace()
      }
 
      return  result.success("Account id ${"NOPE"}")
    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}