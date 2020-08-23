package io.kinny.kin

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.kin.sdk.base.KinAccountContext
import org.kin.sdk.base.KinEnvironment
import org.kin.sdk.base.models.Key
import org.kin.sdk.base.stellar.models.NetworkEnvironment
import org.kin.sdk.base.storage.KinFileStorage
import org.kin.sdk.base.tools.Promise

class BackupRestore(
    private val kinAccountContext: KinAccountContext
): MethodCallHandler {
    private val REQ_CODE_BACKUP = 9000
    private val REQ_CODE_RESTORE = 9001

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "com.example.kin_flutter_sdk/BackupRestore")
            channel.setMethodCallHandler(PlatformChannelPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when {
            call.method == "exportWallet" -> result.success(exportWallet(getBackupManager()))
            else -> result.notImplemented()
        }
        when {
            call.method == "importWallet" -> result.success(importWallet(getBackupManager()))
        }
    }

    private fun createNewWallet(): KinAccountContext {
        val environment: KinEnvironment =
                KinEnvironment.Horizon.Builder(NetworkEnvironment.KinStellarTestNet)
                        .setStorage(KinFileStorage.Builder("path/to/storage/location"))
                        .build()

        var context: KinAccountContext =
                KinAccountContext.Builder(environment)
                        .createNewAccount()
                        .build()

        return context;
    }

    private fun exportWallet() {
        val environment: KinEnvironment =
                KinEnvironment.Horizon.Builder(NetworkEnvironment.KinStellarTestNet)
                        .setStorage(KinFileStorage.Builder("path/to/storage/location"))
                        .build()

        var context: KinAccountContext =
                KinAccountContext.Builder(environment)
                        .createNewAccount()
                        .build()

        return context.
    }

    private fun importWallet(privateKey: Key.PrivateKey, network: NetworkEnvironment): Promise<Boolean> {

        val environment: KinEnvironment =
                KinEnvironment.Horizon.Builder(network)
                        .setStorage(KinFileStorage.Builder("path/to/storage/location"))
                        .build()

        return environment.importPrivateKey(privateKey)
    }
}

