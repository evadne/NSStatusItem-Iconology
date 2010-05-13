//
//  NSStatusItem+Iconology.m
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import "NSStatusItem+Iconology.h"





@interface NSStatusItem (IconologyPrivate)

- (NSSize) _square;

@end





@implementation NSStatusItem (IconologyPrivate)

- (NSSize) _square {

	return NSMakeSize([[NSStatusBar systemStatusBar] thickness], [[NSStatusBar systemStatusBar] thickness]);

}

@end










@implementation NSStatusItem (Iconology)





- (void) setImage:(NSImage *)image withSize:(NSSize)aSize {

	NSImage *statusBarItemIcon = [image copy];

	[statusBarItemIcon setSize:aSize];
	
	[self setImage:statusBarItemIcon];

}





- (void) setAlternateImage:(NSImage *)image withSize:(NSSize)aSize {

	NSImage *statusBarItemIconAlternative = [image copy];

	[statusBarItemIconAlternative setSize:aSize];
	
	[self setAlternateImage:statusBarItemIconAlternative];	

}





- (NSImage *) icon {

	return [self image];

}





- (NSImage *) alternateIcon {

	return [self alternateImage];

}





- (void) setIcon:(NSImage *)image {

	[self setImage:image withSize:[self _square]];

}





- (void) setIcon:(NSImage *)image withAlternateIcon:(NSImage *)anotherImage {

	[self setImage:image withSize:[self _square]];
	[self setAlternateImage:anotherImage withSize:[self _square]];

}





- (void) startAnimation {

	NSView *progressIndicatorHolder = [[NSView alloc] init];

	NSProgressIndicator *progressIndicator = [[NSProgressIndicator alloc] init];

	[progressIndicator setBezeled: NO];
	[progressIndicator setStyle: NSProgressIndicatorSpinningStyle];
	[progressIndicator setControlSize: NSSmallControlSize];
	[progressIndicator sizeToFit];
	[progressIndicator setUsesThreadedAnimation:YES];

	[progressIndicatorHolder addSubview:progressIndicator];
	[progressIndicator startAnimation:self];

	[self setView:progressIndicatorHolder];
	
	[progressIndicator center];
	
	[progressIndicator setNextResponder:progressIndicatorHolder];
	[progressIndicatorHolder setNextResponder:self];

}





- (void) stopAnimation {

	[self setView:nil];

}





- (void) mouseDown:(NSEvent *) theEvent {

	[self popUpStatusItemMenu:[self menu]];

}





- (void) rightMouseUp:(NSEvent *) theEvent {}
- (void) mouseUp:(NSEvent *) theEvent {}

@end




