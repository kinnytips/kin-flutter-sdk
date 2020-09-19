package io.kinny.kin

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.util.Log
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import org.kin.sdk.base.KinAccountContext
import org.kin.sdk.base.KinEnvironment
import org.kin.sdk.base.models.AppInfo
import org.kin.sdk.base.models.AppUserCreds
import org.kin.sdk.base.network.services.AppInfoProvider
import org.kin.sdk.base.stellar.models.NetworkEnvironment
import org.kin.sdk.base.storage.KinFileStorage
import org.kin.sdk.base.models.AppIdx
import org.kin.sdk.base.models.KinAccount
import kin.sdk.Environment
import kin.sdk.KinAccount as KinBaseCompatAccount
import kin.sdk.KinClient
import kin.sdk.exception.CreateAccountException

/** KinSdkPlugin */
public class KinSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity;
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "kin_sdk")
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.applicationContext

    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "kin_sdk")
            channel.setMethodCallHandler(KinSdkPlugin())
        }
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "createAccount" -> {
                return createAccount(result)
            }
            "createBaseCompatAccount" -> {
                return createAccountUsingBaseCompat(result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun createAccountUsingBaseCompat(result: Result) {
        val kinClient = KinClient(activity, Environment.TEST, "1acd")
        val account: KinBaseCompatAccount
        try {
            if (!kinClient.hasAccount()) {
                account = kinClient.addAccount()
                return result.success(account.publicAddress)
            }
        } catch (e: CreateAccountException) {
            e.printStackTrace()
            return result.error("400", "Unable to create account", "Exception")
        }
    }

    private fun createAccount(result: Result) {
        val environment: KinEnvironment =
                KinEnvironment.Agora.Builder(NetworkEnvironment.KinStellarTestNet)
                        .setAppInfoProvider(object : AppInfoProvider {
                            override val appInfo: AppInfo =
                                    AppInfo(
                                            DemoAppConfig.DEMO_APP_IDX,
                                            DemoAppConfig.DEMO_APP_ACCOUNT_ID,
                                            "Kin Demo App", 0
                                    )

                            override fun getPassthroughAppUserCredentials(): AppUserCreds {
                                return AppUserCreds("demo_app_uid", "demo_app_user_passkey")
                            }
                        })
                        .setStorage(KinFileStorage.Builder("/data/user/0/io.kinny.kin/files/kin"))
                        .build()

        val context: KinAccountContext =
                KinAccountContext.Builder(environment)
                        .createNewAccount()
                        .build()

        return result.success(context.accountId.toString())
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }
}

class DemoAppConfig {
    companion object {
        val DEMO_APP_IDX = AppIdx(1)
        val DEMO_APP_ACCOUNT_ID =
                KinAccount.Id("GDHCB4VCNNFIMZI3BVHLA2FVASECBR2ZXHOAXEBBFVUH5G2YAD7V3JVH")
    }
}