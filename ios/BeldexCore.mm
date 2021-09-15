#import "BeldexCore.h"
#include "mymonero-methods.hpp"

@implementation BeldexCore

RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(
  callBeldex,
  callBeldexMethod:(NSString *)method
  arguments:(NSString *)arguments
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject
) {
  const std::string methodString = [method UTF8String];
  const std::string argumentsString = [arguments UTF8String];

  // Find the named method:
  for (int i = 0; i < myMoneroMethodCount; ++i) {
      if (myMoneroMethods[i].name != methodString) continue;

      // Call the method, with error handling:
      try {
          const std::string out = myMoneroMethods[i].method(argumentsString);
          resolve([NSString stringWithCString:out.c_str() encoding:NSUTF8StringEncoding]);
      } catch (...) {
          reject(@"Error", @"beldex-core-cpp threw an exception", nil);
      }
      return;
  }

  reject(
    @"TypeError",
    [NSString stringWithFormat:@"No beldex-core-cpp method %@", method],
    nil
  );
}

@end
