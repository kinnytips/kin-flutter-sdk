#import "KinSdkPlugin.h"
#if __has_include(<kin_sdk/kin_sdk-Swift.h>)
#import <kin_sdk/kin_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kin_sdk-Swift.h"
#endif

@implementation KinSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKinSdkPlugin registerWithRegistrar:registrar];
}
@end
