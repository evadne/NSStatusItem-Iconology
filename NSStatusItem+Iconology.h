//
//  NSStatusItem+Iconology.h
//  moreWord
//
//  Created by Evadne Wu on 5/13/10.
//  Copyright 2010 Iridia Productions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "NSView+Centering.h"
#import "NSView+DumpDimensions.h"





@interface NSStatusItem (Iconology)





//	Sets the image and the alternate image by scaling the input.

- (void) setImage:(NSImage *)image withSize:(NSSize)aSize;
- (void) setAlternateImage:(NSImage *)image withSize:(NSSize)aSize;

- (NSImage *) icon;
- (NSImage *) alternateIcon;

- (void) setIcon:(NSImage *)image;
- (void) setIcon:(NSImage *)image withAlternateIcon:(NSImage *)anotherImage;





//	NSProgressIndicator Freebie

- (void) startAnimation;
- (void) stopAnimation;





//	Stacking an icon — e.g., a warning sign — over what exists ordinary one.

//	- (void) overrideIconWithIcon:(NSImage *) image andAlternateIcon:(NSImage *)anotherImage;
//	- (void) restoreIcon;





@end




