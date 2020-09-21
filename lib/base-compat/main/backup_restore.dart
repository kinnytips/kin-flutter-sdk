

/*class _BackupRestoreState extends State<BackupRestore>  {
  static const platform = const MethodChannel('com.kinecosystem.kin-sdk/BackupRestore');
  // Backup and Restore
  String _exportWalletResult = 'awaiting wallet to export.';
  Future<void> _exportWallet() async {
    String exportWalletResult;
    try {
      exportWalletResult = await platform.invokeMethod('exportWallet');
    } on PlatformException catch (e) {
      exportWalletResult = "Failed to export wallet: '${e.message}'.";
    }

   setState(() {
      _exportWalletResult = exportWalletResult;
    });
  }

  String _importWalletResult;
  Future<void> _importWallet() async {
    String importWalletResult;
    try {
      importWalletResult = await platform.invokeMethod('importWallet');
    } on PlatformException catch (e) {
      importWalletResult = "Failed to import wallet: '${e.message}'.";
    }

   setState(() {
      _importWalletResult = importWalletResult;
    });
  }

}*/
