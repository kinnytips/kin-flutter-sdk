package com.example.kin_flutter_sdk

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kin.backupandrestore.BackupAndRestoreManager

class BackupRestore: MethodCallHandler {
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

    private fun getBackupManager(): BackupAndRestoreManager {
        return BackupAndRestoreManager(this, REQ_CODE_BACKUP, REQ_CODE_RESTORE);
    }

    private fun exportWallet(backupAndRestoreManager: BackupAndRestoreManager) {
        return backupAndRestoreManager.backup()
    }

    private fun importWallet(backupAndRestoreManager: BackupAndRestoreManager) {
        return backupAndRestoreManager.restore()
    }
}

