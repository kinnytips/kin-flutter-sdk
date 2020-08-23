package io.kinny.kin

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.kin.sdk.base.KinEnvironment
import org.kin.sdk.base.stellar.models.NetworkEnvironment
import org.kin.sdk.base.storage.KinFileStorage

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

  private val testKinEnvironment: KinEnvironment.Agora by lazy {
    KinEnvironment.Agora.Builder(NetworkEnvironment.KinStellarTestNet)
            .setAppInfoProvider(object : AppInfoProvider {
              override val appInfo: AppInfo =
                      AppInfo(
                              DemoAppConfig.DEMO_APP_IDX,
                              DemoAppConfig.DEMO_APP_ACCOUNT_ID,
                              "Kin Demo App",
                              R.drawable.app_icon
                      )

              override fun getPassthroughAppUserCredentials(): AppUserCreds {
                return AppUserCreds("demo_app_uid", "demo_app_user_passkey")
              }
            })
            .setStorage(KinFileStorage.Builder("${applicationContext.filesDir}/kin"))
            .build()
            .apply {
              addDefaultInvoices(invoiceRepository)
            }
  }

  private val mainNetKinEnvironment: KinEnvironment.Agora by lazy {
    KinEnvironment.Agora.Builder(NetworkEnvironment.KinStellarMainNet)
            .setAppInfoProvider(this)
            .setStorage(KinFileStorage.Builder("${applicationContext.filesDir}/kin"))
            .build()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
