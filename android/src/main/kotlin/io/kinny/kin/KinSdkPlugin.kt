package io.kinny.kin

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kin.sdk.Environment
import kin.sdk.KinClient
import kin.sdk.exception.CreateAccountException
import org.kin.sdk.base.KinAccountContext
import org.kin.sdk.base.KinEnvironment
import org.kin.sdk.base.models.*
import org.kin.sdk.base.network.services.AppInfoProvider
import org.kin.sdk.base.stellar.models.NetworkEnvironment
import org.kin.sdk.base.storage.KinFileStorage
import org.kin.sdk.base.tools.DisposeBag
import java.math.BigDecimal
import kin.sdk.KinAccount as KinBaseCompatAccount

/** KinSdkPlugin */
class KinSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var context: Context

    // base classes
    private lateinit var environment: KinEnvironment
    private lateinit var kinContext: KinAccountContext

    // base-compat classes
    private lateinit var kinClient: KinClient

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
            // base sdk
            "createAccount" -> {
                return createAccount(call, result)
            }
            "addAccount" -> {
                return addAccount(call, result)
            }
            "getAccountInfo" -> {
                return getAccountInfo(call, result)
            }
            "sendPayment" -> {
                return sendPayment(call, result)
            }
            "getTransactionHistory" -> {
                return getTransactionHistory(call, result)
            }
            // base compat sdk
            "createBaseCompatAccount" -> {
                return createAccountUsingBaseCompat(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    /**
     *
     *
     * BASE SDK implementations
     *
     *
     */


    private fun createAccount(call: MethodCall, result: Result) {
        environment = KinEnvironment.Agora.Builder(NetworkEnvironment.KinStellarTestNet)
                .setAppInfoProvider(object : AppInfoProvider {
                    override val appInfo: AppInfo =
                            AppInfo(
                                    AppIdx(call.argument<Int>("appIdx")!!),
                                    KinAccount.Id(call.argument<String>("appAccountId")!!),
                                    call.argument<String>("appName")!!,
                                    call.argument<Int>("appIconResourceId")!!
                            )

                    override fun getPassthroughAppUserCredentials(): AppUserCreds {
                        return AppUserCreds(
                                call.argument<String>("appUid")!!,
                                call.argument<String>("appUserPasskey")!!)
                    }
                })
                .setStorage(KinFileStorage.Builder("/data/user/0/io.kinny.kin/files/kin"))
                .build()

        kinContext = KinAccountContext.Builder(environment)
                .createNewAccount()
                .build()

        return result.success(kinContext.accountId.toString())
    }

    private fun addAccount(call: MethodCall, result: Result) {
        environment =
                KinEnvironment.Agora.Builder(NetworkEnvironment.KinStellarTestNet)
                        .setAppInfoProvider(object : AppInfoProvider {
                            override val appInfo: AppInfo =
                                    AppInfo(
                                            AppIdx(call.argument<Int>("appIdx")!!),
                                            KinAccount.Id(call.argument<String>("appAccountId")!!),
                                            call.argument<String>("appName")!!,
                                            call.argument<Int>("appIconResourceId")!!
                                    )

                            override fun getPassthroughAppUserCredentials(): AppUserCreds {
                                return AppUserCreds(
                                        call.argument<String>("appUid")!!,
                                        call.argument<String>("appUserPasskey")!!)
                            }
                        })
                        .setStorage(KinFileStorage.Builder("/data/user/0/io.kinny.kin/files/kin"))
                        .build()
        environment.importPrivateKey(Key.PrivateKey(call.argument<String>("privateKey")!!)).then {
            io.flutter.Log.d("KIN_SDK", "Private key is imported.")
            kinContext =
                    KinAccountContext.Builder(environment)
                            .useExistingAccount(KinAccount.Id(call.argument<String>("appAccountId")!!))
                            .build()
            return@then result.success(kinContext.accountId.toString())
        }
    }

    private fun sendPayment(call: MethodCall, result: Result) {
        kinContext.sendKinPayment(KinAmount(call.argument<Double>("amount")!!), KinAccount.Id(call.argument<String>("destinationAccountId")!!))
                .then {
                    return@then result.success(kinContext.accountId.toString())
                }
    }

    private fun getAccountInfo(call: MethodCall, result: Result) {
        var value = "-1"
        kinContext.getAccount().then { kinAccount: KinAccount ->
            value = kinAccount.balance.amount.value.toString()
            Log.i("AMOUNT","Amount is retrieved")
            Log.i("AMOUNT","Amount is returned")
            return@then result.success(value)
        }
    }

    private fun getTransactionHistory(call: MethodCall, result: Result) {
        val lifecycle = DisposeBag()
        kinContext.observePayments()
                .add { payments: List<KinPayment> ->
                    return@add result.success(kinContext.accountId.toString())
                }
                .disposedBy(lifecycle)
    }

    /**
     *
     *
     * BASE COMPAT sdk implementations
     *
     *
     */


    private fun createAccountUsingBaseCompat(call: MethodCall, result: Result) {
        val env = if (call.argument<Boolean>("isProduction")!!) Environment.PRODUCTION else Environment.TEST
        kinClient = KinClient(activity, env, call.argument<String>("appId"))
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

    private fun addAccountUsingBaseCompat(call: MethodCall, result: Result) {
    }

    private fun sendPaymentUsingBaseCompat(call: MethodCall, result: Result) {

    }

    private fun getAccountInfoUsingBaseCompat(call: MethodCall, result: Result) {
        val account: KinBaseCompatAccount
        if (kinClient.hasAccount()) {
            account = kinClient.getAccount(0)
            return result.success(account.publicAddress)
        } else {
            result.success("No Account")
        }
    }

    private fun getTransactionHistoryUsingBaseCompat(call: MethodCall, result: Result) {

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
