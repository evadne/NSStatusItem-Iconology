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

	return NSMakeSize(
	
		[[NSStatusBar systemStatusBar] thickness], 
		[[NSStatusBar systemStatusBar] thickness]
	
	);

}

@end










@interface NSProgressIndicatorView : NSView {
	
	NSProgressIndicator *indicator;
	NSView __weak *enclosingView;
	
}

@property (retain) NSProgressIndicator *indicator;
@property (assign) NSView __weak *enclosingView;

@end





@implementation NSProgressIndicatorView

@synthesize indicator, enclosingView;





- (NSProgressIndicatorView *) init {

	self = [super init];
	
	self.indicator = [[NSProgressIndicator alloc] init];
	
	[indicator setBezeled:NO];
	[indicator setStyle:NSProgressIndicatorSpinningStyle];
	[indicator setControlSize:NSSmallControlSize];
	[indicator sizeToFit];
	[indicator setUsesThreadedAnimation:YES];
	
	[self addSubview:indicator];
	
	[indicator center];
		
	return self;

}





- (void) drawRect:(NSRect)dirtyRect {

	if ([self.enclosingView respondsToSelector:@selector(drawRect:)])
	if (!!self.enclosingView) [self.enclosingView drawRect:dirtyRect];

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










# pragma mark Animation — using NSProgressIndicatorView

- (void) startAnimation {

	NSProgressIndicatorView *progressIndicatorHolder = [[NSProgressIndicatorView alloc] init];
	
	[self setView:progressIndicatorHolder];
//	progressIndicatorHolder.enclosingView = self;

	[progressIndicatorHolder.indicator center];
	[progressIndicatorHolder.indicator startAnimation:self];
	
	CALayer * aViewLayer = [CALayer layer];
	
	[progressIndicatorHolder setLayer:aViewLayer];
	[progressIndicatorHolder setWantsLayer:YES];
	[progressIndicatorHolder setContentFilters:[NSArray arrayWithObject:[CIFilter filterWithName:@"CIColorInvert"]]];

	[progressIndicatorHolder.indicator setNextResponder:(NSResponder *)progressIndicatorHolder];
	[progressIndicatorHolder setNextResponder:(NSResponder *)self];

}





- (void) stopAnimation {

	[self.view removeFromSuperview];
	[self setView:nil];
	
}










# pragma mark Menu Handlers

- (void) menuWillOpen:(NSMenu *)menu {

	if ([self view]) [[self view] setWantsLayer:NO];

	if (![self view]) return;
	[self drawStatusBarBackgroundInRect:[self view].bounds withHighlight:YES];

}

- (void) menuDidClose:(NSMenu *)menu {

	if ([self view]) [[self view] setWantsLayer:YES];
	
}





- (void) drawRect:(NSSize)theFrame {
	
	[self drawStatusBarBackgroundInRect:[self view].bounds withHighlight:YES];
	
}










# pragma mark Trapping Mouse Events

- (void) mouseDown:(NSEvent *)theEvent {

	[self popUpStatusItemMenu:[self menu]];
	
}

- (void) rightMouseUp:(NSEvent *) theEvent {}
- (void) mouseUp:(NSEvent *) theEvent {}





@end




