//I don't think you need these headers to compile because I couldn't find them on my computer :p
#include <ifaddrs.h>
#include <arpa/inet.h>

//I got this code from the internet, hope it works ;)
@interface someInterface : NSObject
- (NSString *)getIPAddress;
@end

@implementation someInterface
- (NSString *)getIPAddress
{
  NSString *address = @"slide to unlock"; //so that if no IP Address if found, it looks like normal
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  int success = 0;

  // retrieve the current interfaces - returns 0 on success
  success = getifaddrs(&interfaces);
  if (success == 0) {
    // Loop through linked list of interfaces
    temp_addr = interfaces;
    while (temp_addr != NULL) {
      if( temp_addr->ifa_addr->sa_family == AF_INET) {
        // Check if interface is en0 which is the wifi connection on the iPhone
        if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
          // Get NSString from C String
          address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
        }
      }

      temp_addr = temp_addr->ifa_next;
    }
  }

  // Free memory
  freeifaddrs(interfaces);

  return address;
}
@end


%hook SBLockScreenView
//method for iOS 6 and 7 (at least)
- (void)setCustomSlideToUnlockText:(id)arg1
{
	someInterface *IPAddr = [someInterface new]; //using this is the same as [[class alloc] init]; if you didn't know :)
	arg1 = [IPAddr getIPAddress];
	%orig(arg1);
	[IPAddr release];
}
//method for iOS 8
- (id)_defaultSlideToUnlockText{
	someInterface *IPAddr = [someInterface new]; //using this is the same as [[class alloc] init]; if you didn't know :)
	
	return [IPAddr getIPAddress]; 
	[IPAddr release];
}
%end
