#import "FlutterMyPickerNullSafetyPlugin.h"
#if __has_include(<flutter_my_picker_null_safety/flutter_my_picker_null_safety-Swift.h>)
#import <flutter_my_picker_null_safety/flutter_my_picker_null_safety-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_my_picker_null_safety-Swift.h"
#endif

@implementation FlutterMyPickerNullSafetyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMyPickerNullSafetyPlugin registerWithRegistrar:registrar];
}
@end
