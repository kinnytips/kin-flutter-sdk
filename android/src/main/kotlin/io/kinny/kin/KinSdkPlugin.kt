package io.kinny.kin

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.util.Log

import org.kin.sdk.base.KinAccountContext
import org.kin.sdk.base.KinEnvironment
import org.kin.sdk.base.models.AppInfo
import org.kin.sdk.base.models.AppUserCreds
import org.kin.sdk.base.network.services.AppInfoProvider
import org.kin.sdk.base.stellar.models.NetworkEnvironment
import org.kin.sdk.base.storage.KinFileStorage
import org.kin.sdk.base.models.AppIdx
import org.kin.sdk.base.models.KinAccount

/** KinSdkPlugin */
public class KinSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "kin_sdk")
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "kin_sdk")
      channel.setMethodCallHandler(KinSdkPlugin())
    }
  }


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } 
    else if(call.method == "createAccount"){

      val environment: KinEnvironment =
      KinEnvironment.Agora.Builder(NetworkEnvironment.KinStellarTestNet)
          .setAppInfoProvider(object : AppInfoProvider {
              override val appInfo: AppInfo =
                  AppInfo(
                      DemoAppConfig.DEMO_APP_IDX,
                      DemoAppConfig.DEMO_APP_ACCOUNT_ID,
                      "Kin Demo App",0
                  )

              override fun getPassthroughAppUserCredentials(): AppUserCreds {
                  return AppUserCreds("demo_app_uid", "demo_app_user_passkey")
              }
          })
          .setStorage(KinFileStorage.Builder("/data/user/0/io.kinny.kin_sdk_example/files/kin"))
          .build()

  var context: KinAccountContext =
      KinAccountContext.Builder(environment)
          .createNewAccount()
          .build()
 
return  result.success("Account id ${context.accountId.toString()}")
    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

class DemoAppConfig {
  companion object {
      // Used to test with no webhook (0 is webhook un-set pure pass through to the blockchain)
//        val DEMO_APP_IDX = AppIdx(0)
//        val DEMO_APP_ACCOUNT_ID =
//            KinAccount.Id("GAO47SC3PMCXVWIQLZSKUCFZQ4MLUAEZIPPILUKSFCFQDCHZHGZJDNQ6")


      // Used to test with webhook - blindly whitelists with no restrictions
      val DEMO_APP_IDX = AppIdx(1)
      val DEMO_APP_ACCOUNT_ID =
          KinAccount.Id("GDHCB4VCNNFIMZI3BVHLA2FVASECBR2ZXHOAXEBBFVUH5G2YAD7V3JVH")
  }
}