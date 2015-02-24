NSString* newText = @"";
int count = 0;

%hook SBLockScreenView
- (void)setCustomSlideToUnlockText:(id)text{
	
	/*
	//Strings in c are weird. Or maybe I'm just stupid.
	//ffs this shit
	//follow the what-the-errors-tell-me-to-do road, follow the what-the-errors-tell-me-to-do road 
	//k i just used NSString UTF8String instead but i'll just leave these comments here as a milestone of how weird strings are in c coming from java
	const char [43] cmd1 = "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\"";
	const char [34] cmd2 = ".){3}[0-9]*' | grep -Eo '([0-9]*\"";
	const char [50] cmd3 = ".){3}[0-9]*' | grep -v '127.0.0.1' > /tmp/slideip";

    system(strcat( strcat(cmd1, cmd2), cmd3));
	
    
	NSString cmd1 = @"ifconfig | grep -Eo 'inet (addr:)?([0-9]*\";
	NSString cmd2 = ".){3}[0-9]*' | grep -Eo '([0-9]*\"";
	NSString cmd3 = ".){3}[0-9]*' | grep -v '127.0.0.1' > /tmp/slideip"
	*/
	NSString *NSStringCMD = @"ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1' > /tmp/slideip";
	system([NSStringCMD UTF8String]);
	newText = [[NSString alloc] initWithContentsOfFile:@"/tmp/slideip" encoding:NSUTF8StringEncoding error:nil];
	count++;
	newText = [newText stringByAppendingString:[NSString stringWithFormat:@" #%i", count]];
	
}
%end






/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
