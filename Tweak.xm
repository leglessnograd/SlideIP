NSString* newText = @"";
int count = 0;

%hook SBLockScreenView
- (void)setCustomSlideToUnlockText:(id)text:(BOOL)idek
{
	
	


NSLog(@"---------------------------------------------------------------------------------------------------------------------------------------------\n\n\n\n\n\n\n\n\n\\n\\n\\n\\n\\n\\n\n-------------------------------------------------------------------------------------------------------------------------------------------------");
	%log;
	NSLog(@"---------------------------------------------------------------------------------------------------------------------------------------------\n\n\n\n\n\n\n\n\n\\n\\n\\n\\n\\n\\n\n-------------------------------------------------------------------------------------------------------------------------------------------------");
	NSLog(@"text: %@, idek: %d", text, idek);
	return %orig(@"newText", idek); //lets just get the actual thing 
to work before worrying about the ip
		NSLog(@"---------------------------------------------------------------------------------------------------------------------------------------------\n\n\n\n\n\n\n\n\n\\n\\n\\n\\n\\n\\n\n-------------------------------------------------------------------------------------------------------------------------------------------------");

}
%end
